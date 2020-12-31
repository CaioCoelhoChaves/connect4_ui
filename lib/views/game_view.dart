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
  double _gridWidth;

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
        body: LayoutBuilder(
          builder: (context, constraints){
            if(constraints.maxWidth <= 770) _gridWidth = 80*vw;
            else if(constraints.maxWidth > 770 && constraints.maxWidth < 1150) _gridWidth = 60*vw;
            else if(constraints.maxWidth >= 1150 && constraints.maxWidth < 1415) _gridWidth = 50*vw;
            else _gridWidth = 40*vw;
            return WillPopScope(
              child:Stack(
                    children: [
                      Center(
                        child: Container(
                          width: _gridWidth,
                          child: GridView.builder(
                            shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 5.0,
                                childAspectRatio: 1.0,
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
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(300),
                                        child: Container(
                                          color: color,
                                        ),
                                      );
                                    },
                                  )
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: _gridWidth,
                          child: ListView.builder(
                            itemCount: 7,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_,index){
                              return GestureDetector(
                                onTap: (){
                                  _controller.newPlay(index, widget.room);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  height: double.maxFinite,
                                  width: _gridWidth/7,
                                ),
                              );
                            },
                          )

                          /*Row(
                            children: [
                              Container(
                                height: double.maxFinite,
                                width: _gridWidth/7,
                                color: Colors.red,
                              ),
                            ],
                          ),*/
                        ),
                      )
                    ],
                  ),
              onWillPop: (){
                return Future.value(true);
              },
            );
          }
        )
    );
  }
}