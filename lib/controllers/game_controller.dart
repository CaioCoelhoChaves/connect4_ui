
import 'dart:convert';

import 'package:connect4/main.dart';
import 'package:get/get.dart';

class GameController extends GetxController{

  var status = "".obs;
  var tiles = new List(42).obs;
  var playerTurn = "".obs;
  var winner = "none".obs;

  @override
  void onInit(){
    super.onInit();

    for(int i = 0; i < tiles.length; i++){
      tiles[i] = "white";
    }

    MySocket.socket.on('status', (status){
      print(status);
      this.status.value = status;
    });

    MySocket.socket.on('turn', (player){
      print(player);
      this.playerTurn.value = player;
    });

    MySocket.socket.on('tiles', (tiles){
      this.tiles.assignAll(jsonDecode(tiles));
    });

    MySocket.socket.on('connected', (data){

    });

    MySocket.socket.on('theWinner', (winner){
      if(!Get.isSnackbarOpen){
        Get.snackbar('Temos um vencedor!', 'Jogador de cor: ' + winner);
      }
    });

    MySocket.socket.on('error', (error){
      print(error);
      Get.snackbar('Erro!', error);
    });

  }

  void newPlay(int column, String room){
    MySocket.socket.emit('newPlay', {'column' : column, 'room' : room});
  }

}