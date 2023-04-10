// import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/player.dart';
import 'package:player/video_view.dart';

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
    var player = Player();
    player.setCommonDataSource(url, autoPlay: true);
    // 长按视频弹窗
    return GestureDetector(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("提示"),
                  content: Text("确认下载视频吗"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, 'cancer'),
                        child: Text('取消')),
                    TextButton(
                        onPressed: () => print('mooc,确认下载'),
                        child: const Text('确认')),
                  ],
                );
              });
        },
        child: VideoView(player));
  }

// @override
// Widget build(BuildContext context) {
//   var player = FijkPlayer()..setDataSource(url,autoPlay: true);
//   return Scaffold(body:FijkView(player: player));
// }
}
