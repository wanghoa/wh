import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/player.dart';

class VideoView extends StatefulWidget {
  final Player player;
  const VideoView(this.player);
  @override
  State<StatefulWidget> createState()=>_VideoViewState();

}

class _VideoViewState extends State<VideoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    GestureDetector(
      onTap: ontapVideo,
      child: Stack(
        children: [
          AbsorbPointer(absorbing: true,child:FijkView(player: widget.player)),
          if(widget.player.state == FijkState.paused)//播放器状态
            Align(// 居中对齐
              alignment: Alignment.center,// 居中对齐
              child: Image.asset(
                  'asset/images/play.png', width: 60, height: 60),)
        ]),

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
  @override
  void dispose() {
    super.dispose();
    //页面退出释放播放器(回收资源)
    widget.player.release();
  }
}