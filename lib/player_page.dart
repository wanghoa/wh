// import 'package:fijkplayer/fijkplayer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:player/player.dart';
import 'package:player/video_view.dart';
import 'package:wh/favorite_gesture.dart';

/*
 播放页面存在三层View；双击 是点赞；长按： 下载；单击是暂停播放
 顶层：双击事件 然后是长按,最里面是点击
 */
class PlayerPage extends StatefulWidget {
  final String videoUrl;

  const PlayerPage({this.videoUrl = ''});

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
    player.setCommonDataSource(
        widget.videoUrl, type: SourceType.net, autoPlay: true);
    // FavoriteGesture 内部实现双击事件
    return FavoriteGesture(child: GestureDetector( // 长按视频弹窗
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
                        onPressed: () {
                          _saveVideo(widget.videoUrl);
                          Navigator.pop(context, '');
                        },
                        child: const Text('确认')),
                  ],
                );
              });
        },
        child: VideoView(player)));
  }

  /*
   * 下载视频并存储到本地
   */
  void _saveVideo(String urlPath) async {
    print('save video:$url');
    //url 也是uri 我们通过uri将URL解析出来
    Uri uri = Uri.parse(urlPath);
    String name = uri.pathSegments.last; // 获取路径
    // var path = getAppPath();// 内部使用MethodChannel 调用到native层。分别在Android与iOS上实现MethodChannel。返回用户可以保存的路径
    // 这里我们使用第三方库也是使用MethodChannel
    var dir =
    await getExternalStorageDirectory(); // path_provider库  获取sdcart视频存储路径；Android与iOS分别获取不同路径
    String savePath = "${dir?.path}/$name";
    var result = await Dio().download(urlPath, savePath,
        onReceiveProgress: (count, total) {
          var progress = '${(count / total * 100).toInt()}%';
          print('打印下载进度：$progress');
        });
    print('result:$result');
  }

// @override
// Widget build(BuildContext context) {
//   var player = FijkPlayer()..setDataSource(url,autoPlay: true);
//   return Scaffold(body:FijkView(player: player));
// }
}
