import 'package:connect4/views/app_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  //Connect with socket.io
  MySocket.socket = IO.io('http://localhost:3000', <String, dynamic>{
    'transports': ['websocket'],
  });
  runApp(
      GetMaterialApp(
        home: AppView(),
        debugShowCheckedModeBanner: false,
      )
  );

}

class MySocket{
  static IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{
    'transports': ['websocket'],
  });

}
