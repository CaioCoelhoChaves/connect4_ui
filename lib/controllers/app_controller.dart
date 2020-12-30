import 'dart:convert';
import 'package:connect4/views/game_view.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:connect4/main.dart';

class AppController extends GetxController {

  var rooms = new List().obs;
  String roomJoined;

  @override
  void onInit() {
    super.onInit();

    //Print connect when connected
    MySocket.socket.onConnect((data) => print('connect'));

    //Receive rooms from Socket.io
    MySocket.socket.on('rooms', (data) {
      rooms.assignAll(jsonDecode(data));
    });

    MySocket.socket.on('error', (error){
      Get.snackbar('Erro!', error);
    });

    MySocket.socket.on('connected', (data){
      Get.to(GameView(room: this.roomJoined,));
    });

  }

    void createRoom(String roomName) {
      MySocket.socket.emit('createRoom', roomName);
      this.roomJoined = roomName;
    }

    void joinRoom(String roomName) {
      MySocket.socket.emit('join', roomName);
      this.roomJoined = roomName;
    }

    void newPlay(int column) {

    }


}