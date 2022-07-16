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
  console.log(socket.id);
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
      const roomId = room._id.toString();
      console.log(nickname);
      console.log(roomId);
      socket.join(roomId);
      //socket -> sends data to yourself
      //io -> sends data to everyone in room
      io.to(roomId).emit("roomCreated", room); //from sever to room
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
