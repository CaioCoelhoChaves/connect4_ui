import 'package:connect4/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  AppController _controller = Get.put(new AppController());
  TextEditingController _roomNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double vw = 0.01 * (MediaQuery.of(context).size.width);
    double vh = 0.01 * (MediaQuery.of(context).size.height);
    return Scaffold(
        appBar: AppBar(
          title: Text("Connect 4 - Online Rooms"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.defaultDialog(
                title: "Criar nova sala",
                content: Column(
                  children: [
                    TextField(
                      controller: _roomNameController,
                      decoration: InputDecoration(
                        fillColor: Colors.blue,
                        border: OutlineInputBorder(),
                        labelText: 'Nome da sala',
                      ),
                    ),
                    SizedBox(
                      height: 1 * vh,
                    ),
                    RaisedButton(
                      child: Text("Criar"),
                      color: Colors.blue,
                      onPressed: () {
                        Get.back();
                        _controller.createRoom(_roomNameController.text);
                        _roomNameController.text = "";
                      },
                    )
                  ],
                ));
          },
        ),
        body: GetX<AppController>(
          builder: (_) {
            if (_controller.rooms.isEmpty) {
              return Center(
                child: Text("Não há salas disponiveis"),
              );
            } else {
              return ListView.builder(
                itemCount: _controller.rooms.length,
                itemBuilder: (_, index) => GetX<AppController>(builder: (_) {
                  return Card(
                    child: ListTile(
                      leading: SizedBox(
                        width: 5 * vw,
                      ),
                      title: Text(_controller.rooms[index]),
                      subtitle: Text("Connect4"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      onTap: () {
                        _controller.joinRoom(_controller.rooms[index]);
                      },
                    ),
                  );
                }),
              );
            }
          },
        ));
  }
}
