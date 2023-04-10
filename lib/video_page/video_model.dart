import 'package:json_annotation/json_annotation.dart';
part 'video_model.g.dart';

@JsonSerializable()
class VideoModel {
  String title = '';
  String url = '';
  int playCount = 0;

  VideoModel(this.title, this.url, this.playCount); // win+n (MAC Command+N)

  // 相当于Java实现工厂设计模式
  factory VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);
  //     // VideoModel(json['title'], json['url'], json['playCount']);// 这里的title,url,playCount 要与服务端一致
  //
  Map<String, dynamic> toJson(VideoModel instance) => _$VideoModelToJson( instance);

}
