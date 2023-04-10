import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wh/video_page/server_data.dart';
import 'package:wh/video_page/video_model.dart';

class VideoController {
  // static const data1 = {
  // "title": "实例视频"，
  // "url": "https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv",
  // "playCount": 66
  // }

  // static const _serverData = """{
  // "title":"实例视频"，
  // "url","https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv",
  // "playCount":66}  """; //三引号内的为字符串数据  模拟服务端返回的json数据

  // Map<String, dynamic> _videoData = {};//第一种方案
   VideoModel? model; //第二种方案

  Future<void> init() async {
    // _videoData = fetchVideoData();//第一种方案
    // model = fetchVideoData2();//第二种方案
    model ??= await fetchVideoData3();
    // if (model == null) {      // 首先判断一级缓存 既内存中是否有数据
    //   // 没有，从二级或三级缓存中查找 then 为异步执行
    //   // fetchVideoData3().then((value)=>model = value);//先执行方法 获取到value值 ，再将value赋值给model
    //   model = await fetchVideoData3(); // 使用await 会阻塞流程；就是init方法执行后，程序才会向下执行其他方法如 ：VideoList的生命周期build()
    // }
  }

// 从Map中获取数据 //第一种方案
//   String get title => _videoData['title'];
//   String get url => _videoData['url'];
//   int get playCount => _videoData['playCount'];

  /**
   * 从服务端获取json字符串 类型表示的视频数据
   */
  // Map<String, dynamic> fetchVideoData() {//第一种方案
  //   return jsonDecode(_serverData); // json转 map
  // }

  // VideoModel fetchVideoData2() {//第二种方案
  //   return VideoModel.fromJson(jsonDecode(_serverData));
  // }
  // 增加缓存逻辑  第三种优化方案
  Future<VideoModel> fetchVideoData3() async{
    var sp  = await SharedPreferences.getInstance();
    var modelStr = sp.getString('videoModel');
    if (modelStr != null && modelStr.isNotEmpty) {
      // 二级缓存中有数据直接使用 。（一级缓存是内存）
      return VideoModel.fromJson(jsonDecode(modelStr));

    }else{
      //三级缓存
      var model = jsonDecode(ServerData.fetchDataFromServer());
      var sp = await SharedPreferences.getInstance();
      sp.setString('videoModel', ServerData.fetchDataFromServer());
      return VideoModel.fromJson(model);
    }



    return VideoModel.fromJson(jsonDecode(ServerData.fetchDataFromServer()));
  }
}
