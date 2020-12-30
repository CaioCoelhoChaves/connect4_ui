import 'package:connect4/controllers/app_controller.dart';
import 'package:connect4/controllers/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GameView extends StatefulWidget {

  final String room;
  const GameView({Key key, this.room}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  GameController _controller = Get.put(new GameController());

  @override
  Widget build(BuildContext context) {
    double vw = 0.01 * (MediaQuery
        .of(context)
        .size
        .width);
    double vh = 0.01 * (MediaQuery
        .of(context)
        .size
        .height);
    return Scaffold(
        appBar: AppBar(
          title: Text("Connect 4 - " + widget.room),

        ),
        backgroundColor: Colors.black87,
        body: WillPopScope(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:2*vh),
                  width: 80*vw,
                  height: 10*vh,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (_,index) =>
                    Container(
                      color: Colors.blue,
                      width: (80*vw) / 7,
                      child: FlatButton(
                        child: Icon(Icons.arrow_drop_down, size: 3*vh,),
                        onPressed:  (){_controller.newPlay(index, widget.room);},
                      )
                    ),
                  ),
                ),
                Container(
                  width: 80 * vw,
                  height: 70*vh,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: 42,
                      itemBuilder: (_, index) =>
                          GetX<AppController>(
                            builder: (_) {
                              Color color = Colors.white;
                              switch(_controller.tiles[index]){
                                case 'white': color = Colors.white;
                                break;
                                case 'blue': color = Colors.blue;
                                break;
                                case 'red': color = Colors.red;
                              }
                              return Container(
                                color: color,
                              );
                            },
                          )
                  ),
                ),
              ],
            )
          ),
          onWillPop: (){
            return Future.value(true);
          },
        )
    );
  }
}