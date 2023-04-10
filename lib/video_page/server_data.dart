class ServerData {

  static String fetchDataFromServer() {
    //模拟网络获取数据，在实际项目中是从服务端接口获取数据
    return """
     "title":"实例视频"，
     "url","https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv",
     "playCount":66} 
      """;
  }
}
