// import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/player.dart';

class PlayerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlayerPageState();
  }
}

class _PlayerPageState extends State<PlayerPage> {
  static const String url =
      'https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv';
   String version = 'null';
  @override
  void initState() {
    super.initState();
    // Player.getPlatformVersion.then((value) => null);
    // Player.getPlatformVersion.then((value){
    //   // setState(() {});
    //   setState(()=>version = value);
    // });
  }
  @override
  Widget build(BuildContext context) {

    var  player = Player();
    player.setCommonDataSource(url,autoPlay: true);
    return VideoView(player);

  }

  // @override
  // Widget build(BuildContext context) {
  //   var player = FijkPlayer()..setDataSource(url,autoPlay: true);
  //   return Scaffold(body:FijkView(player: player));
  // }
}
