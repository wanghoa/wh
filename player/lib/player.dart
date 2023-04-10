import 'dart:io';

import 'package:fijkplayer/fijkplayer.dart';

import 'player_platform_interface.dart';

class Player extends FijkPlayer {
  Future<String?> getPlatformVersion() {
    return PlayerPlatform.instance.getPlatformVersion();
  }

  static const cache_switch = 'ijkio:cache:ffio:'; //ijk官方文档提供的
  static String _cachePath =
      '/storage/emulated/0/Android/data/包名/file'; // 默认cachePath
  bool enbaleCache = true;
  static const asset_url_suffix = 'asset：///';

  static void setCachePath(String path) {
    // 调用方设置自己的路径
    _cachePath = path;
  }

  //给url 添加前缀
  @override
  Future<void> setDataSource(String path,
      {bool autoPlay = false, bool showCover = false}) async {
    var videoPath = getVideoCatchPath(path, _cachePath);
    // 三级缓存
    if (File(videoPath).existsSync()) {
      // 如果二级缓存存在，直接用本地保存的视频文件播放
      path = videoPath;
    } else if (enbaleCache) {
      //是否需要缓存
      // 本地没有缓存 需要从服务端获取(走三级缓存逻辑，并添加到二级缓存-本地磁盘中)
      path = '$cache_switch$path'; //路径前添加前缀
      setOption(
          FijkOption.formatCategory, 'cache_file_path', videoPath); // 给播放器设置开关
    } else {}

    super.setDataSource(path, autoPlay: autoPlay, showCover: showCover);
  }

  void setCommonDataSource(String url,
      {SourceType type = SourceType.net,
      bool autoPlay = false,
      bool showCover = false}) {
    if (type == SourceType.asset && !url.startsWith(asset_url_suffix)) {}
    setDataSource(url, autoPlay: autoPlay, showCover: showCover);
  }

  String getVideoCatchPath(String url, String cachePath) {
    Uri uri = Uri.parse(url);
    String name = uri.pathSegments.last;
    var path = '$cachePath/$name';
    print('存放路径+文件名称: $path');
    return path;
  }
}

enum SourceType { net, asset }
