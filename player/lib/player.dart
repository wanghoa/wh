import 'package:fijkplayer/fijkplayer.dart';

import 'player_platform_interface.dart';

class Player extends FijkPlayer {
  Future<String?> getPlatformVersion() {
    return PlayerPlatform.instance.getPlatformVersion();
  }
  static const  asset_url_suffix='null';
  void setCommonDataSource(String url,
      {SourceType type = SourceType.net,
      bool autoPlay = false,
      bool showCover = false}) {
    if (type ==  SourceType.asset && !url.startsWith(asset_url_suffix)) {

    }
    setDataSource(url,autoPlay: autoPlay,showCover: showCover);
  }
}

enum SourceType { net, asset }
