
import 'dart:convert';

import 'package:connect4/main.dart';
import 'package:flutter/material.dart';
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
      this.status.value = status;
    });

    MySocket.socket.on('turn', (player){
      this.playerTurn.value = player;
    });

    MySocket.socket.on('tiles', (tiles){
      this.tiles.assignAll(jsonDecode(tiles));
    });

    MySocket.socket.on('connected', (data){

    });

    MySocket.socket.on('theWinner', (winner){
      String winnerColor;
      if(winner == 'blue') winnerColor = "Azul.";
      else if(winner == 'red') winnerColor = "Vermelha.";

      if(!Get.isDialogOpen){
        Get.defaultDialog(
          title: "Temos um vencedor!",
          content: Text("Jogador de cor: " + winnerColor),
        );
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