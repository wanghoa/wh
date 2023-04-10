import 'dart:convert';

class VideoController {

  // static const data1 = {
  // "title": "实例视频"，
  // "url": "https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv",
  // "playCount": 66
  // }

  static const _serverData ="""{
  "title":"实例视频"，
  "url","https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv",
  "playCount":66}  """;//三引号内的为字符串数据  模拟服务端返回的json数据

Map<String,dynamic> _videoData = {};
void init(){
  _videoData = fetchVideoData();
}

String get title => _videoData['title'];
String get url=> _videoData['url'];
String get playCount => _videoData['playCount'];


  /**
   * 从服务端获取json字符串 类型表示的视频数据
   */
  Map<String, dynamic> fetchVideoData() {
  return  jsonDecode(_serverData);// json转 map
  }

}