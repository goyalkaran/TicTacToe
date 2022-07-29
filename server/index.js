const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const database = require("./keys/mongoKey");
const Room = require("./models/room");
const app = express();
const port = process.env.PORT || 8000;

const server = http.createServer(app);
//shortcut
//middleware
//client -> middleware -> server
app.use(express.json());

const io = require("socket.io")(server);

io.on("connection", (socket) => {
  console.log("successful connection!");
  //listening from emit in socket_methods
  socket.on("createRoom", async ({ nickname }) => {
    //creating room
    try {
      let room = new Room(); //room instance
      //entering player in room
      let player = {
        socketID: socket.id,
        nickname,
        playerType: "X",
      };
      room.players.push(player);
      room.playerTurn = player;
      room = await room.save();
      // room id
      const roomID = room._id.toString();
      socket.join(roomID);
      console.log(roomID);
      //      console.log(room);
      //socket -> sends data to yourself
      //io -> sends data to everyone in room
      io.to(roomID).emit("roomCreated", room); //from sever to room
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("joinRoom", async ({ nickname, roomID }) => {
    try {
      if (roomID.match(/^[0-9a-fA-F]{24}$/)) {
        let room = await Room.findById(roomID);
        if (room.isJoin) {
          let player = {
            nickname,
            socketID: socket.id,
            playerType: "O",
          };
          socket.join(roomID);
          room.players.push(player);
          room.isJoin = false;
          room = await room.save();
          io.to(roomID).emit("roomJoined", room); //from sever to room
          io.to(roomID).emit("updatePlayer", room.players);
          io.to(roomID).emit("updateRoom", room);
          console.log(room["players"]);
        } else {
          socket.emit(
            "errorFound",
            "Room is full please wait and try again later."
          );
        }
      } else {
        socket.emit("errorFound", "Enter valid Room ID.");
      }
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("tap", async ({ index, roomID }) => {
    try {
      let room = await Room.findById(roomID);
      let choice = room.playerTurn.playerType;
      if (room.turnIndex == 0) {
        room.playerTurn = room.players[1];
        room.turnIndex = 1;
      } else {
        room.playerTurn = room.players[0];
        room.turnIndex = 0;
      }
      room = await room.save();
      io.to(roomID).emit("tapped", {
        index,
        choice,
        room,
      });
    } catch (e) {
      console.log(e);
    }
  });
  socket.on("winner", async ({ winnerSocketID, roomID }) => {
    try {
      let room = await Room.findById(roomID);
      let player = room.players.find(
        (played) => played.socketID == winnerSocketID
      );
      player.points += 1;
      room = await room.save();
      if (player.points >= room.maxRounds) {
        io.to(roomID).emit("endGame", player);
      } else {
        io.to(roomID).emit("pointIncrement", player);
      }
    } catch (e) {
      console.log(e);
    }
  });
});
//creating database
mongoose
  .connect(database)
  .then(() => {
    console.log("Database Connected!");
  })
  .catch((e) => {
    console.log(e);
    console.log("Connection Failed!!!");
  });

server.listen(port, "0.0.0.0", () => {
  console.log(`Server Started and running on port: ${port}`);
});
