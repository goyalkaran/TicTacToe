const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const database = require("./keys/mongoKey");
const Room = require("./models/room");
const app = express();
const port = process.env.PORT || 8000;

var server = http.createServer(app);

//shortcut
var io = require("socket.io")(server);
io.on("connection", (socket) => {
  console.log("successful connection!");
  //listening from emit in socket_methods
  socket.on("createRoom", async ({ nickname }) => {
    //creating room
    try {
      let room = new Room(); //room instance
      //entering player in room
      let player = {
        socketId: socket.id,
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
      //socket -> sends data to yourself
      //io -> sends data to everyone in room
      io.to(roomID).emit("roomCreated", room); //from sever to room

    } catch (e) {
      console.log(e);
    }
  });

  socket.on("joinRoom", async ({ nickname, roomID }) => {
    try {
      if (!roomID.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorFound", "Enter valid Room ID.");
       }
       else{
        let room = await Room.findById(roomID);
        if (room.isJoin) {
          let player = {
            nickname,
            socketId: socket.id,
            playerType: "O",
          };
          console.log(nickname);
          socket.join(roomID);
          room.players.push(player);
          room.isJoin=false;
          room = await room.save();
          io.to(roomID).emit("roomJoined", room); //from sever to room
          io.to(roomID).emit("updatePlayer", room.players);
          io.to(roomID).emit("updateRoom", room);
        } else {
          socket.emit("errorFound", "Room is full please wait and try again later.");
        }
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

//middleware
//client -> middleware -> server
app.use(express.json());

server.listen(port, "0.0.0.0", () => {
  console.log(`Server Started and running on port: ${port}`);
});
