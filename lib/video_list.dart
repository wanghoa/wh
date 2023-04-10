import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/player.dart';
import 'package:player/video_view.dart';
import 'package:wh/main.dart';
import 'package:wh/mc_router.dart';

class VideoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: 10,
            itemBuilder: (context, index) {
              //实际项目中，通过DataList[index]获取url
              var url =
                  'https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv';
              return GestureDetector(
                  child: AbsorbPointer(
                    absorbing: true,
                    child: VideoView(Player()
                      ..setCommonDataSource(
                        'asset/videos/test.flv',
                        type: SourceType.asset,
                        autoPlay: true,
                      )),
                  ),
                  onTap: () async => await router.push(
                      name: MCRouter.playerPage, argument: url));
            }));
  }
}
