import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/player.dart';

class VideoView extends StatefulWidget {
  final Player player;

  const VideoView(this.player)

  @override
  State<StatefulWidget> createState() {
    return _VideoViewState();
  }
}

class _VideoViewState extends State<VideoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    GestureDetector(
      child: Stack(
        children: [FijkView(player: widget.player),
          if(widget.player.state == FijkState.paused)
          // Image.asset('asset/images/play.png')
            Align(
              child: Image.asset(
                  'asset/images/play.png', width: 60, height: 60),
              alignment: Alignment.center,)
        ],
      ), onTap: ontapVideo,

    )

    );
  }

  void ontapVideo() {
    if (widget.player.state == FijkState.paused) { //暂停
      widget.player.start();
    } else {
      widget.player.pause();
    }
    setState(() {}); // 触发重绘
  }
}