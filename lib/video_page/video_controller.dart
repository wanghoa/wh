import 'dart:convert';

import 'package:wh/video_page/video_model.dart';

class VideoController {
  // static const data1 = {
  // "title": "实例视频"，
  // "url": "https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv",
  // "playCount": 66
  // }

  static const _serverData = """{
  "title":"实例视频"，
  "url","https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv",
  "playCount":66}  """; //三引号内的为字符串数据  模拟服务端返回的json数据

  // Map<String, dynamic> _videoData = {};//第一种方案
  late VideoModel model; //第二种方案

  void init() {
    // _videoData = fetchVideoData();//第一种方案
    model = fetchVideoData2();//第二种方案
  }

// 从Map中获取数据 //第一种方案
//   String get title => _videoData['title'];
//
//   String get url => _videoData['url'];
//
//   int get playCount => _videoData['playCount'];

  /**
   * 从服务端获取json字符串 类型表示的视频数据
   */
  // Map<String, dynamic> fetchVideoData() {//第一种方案
  //   return jsonDecode(_serverData); // json转 map
  // }

  VideoModel fetchVideoData2() {//第二种方案
    return VideoModel.fromJson(jsonDecode(_serverData));
  }
}
