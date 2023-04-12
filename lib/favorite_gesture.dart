import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteGesture extends StatefulWidget {
  static const double defaultSize = 100; //定义常量
  final Widget child;
  final double? size;

  const FavoriteGesture(
      {required this.child, this.size = defaultSize, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoriteGestureState();
}

class _FavoriteGestureState extends State<FavoriteGesture> {
  bool isFavorite = false;
  Offset temp = Offset.zero; //Offset 存储坐标的

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Stack(// 堆叠（FrameLayout）
            children: [
          Container(width: double.infinity, color: Colors.black),
          // 这里Container 代替VideoView;
          if (isFavorite)
            // 作具体位置的摆放  //默认 Icon 不显示
            Positioned(
              top: temp.dy - widget.size! / 2,
              left: temp.dx - widget.size! / 2,
              child: Icon(Icons.favorite,
                  size: widget.size, color: Colors.redAccent),
            )
        ]),
        onTapDown: (details) {
          temp = details.globalPosition;
        },
        onDoubleTap: () {
          // 双击事件  双击刷新页面
          setState(() {
            isFavorite = true;
          });
          //延时
          Future.delayed(Duration(milliseconds: 600), () {
            //(){} 闭包
            setState(() {
              isFavorite = false;
            });
          });
        });
  }
}
