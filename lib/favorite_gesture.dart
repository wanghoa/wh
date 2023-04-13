import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wh/favorite_animation_icon.dart';

/*
绘制红心 ，计算点赞坐标
 */
class FavoriteGesture extends StatefulWidget {
  static const double defaultSize = 100; //定义常量
  final Widget child;
  final double size;

  const FavoriteGesture(
      {required this.child, this.size = defaultSize, Key? key})
      : super(key: key);

  @override
  State<FavoriteGesture> createState() => _FavoriteGestureState();
}

class _FavoriteGestureState extends State<FavoriteGesture> {
  // bool isFavorite = false;
  List<Offset> iconOffsets = []; //保存当前需要展示的icon坐标
  final GlobalKey _key = GlobalKey();
  Offset temp = Offset.zero; //Offset 存储坐标的
  Offset _globalToLocal(Offset offset) {
    RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    return renderBox.globalToLocal(offset);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: _key,
        child: Stack(// 堆叠（FrameLayout）
            children: [
          widget.child,
          //child:VideoView
          // Container(width: double.infinity, color: Colors.black),// 这里Container 代替VideoView;
          // if (isFavorite)
          // 作具体位置的摆放  //默认 Icon 不显示
          Positioned(
              top: temp.dy - widget.size! / 2,
              left: temp.dx - widget.size! / 2,
              child: FavoriteAnimationIcon(
                key: GlobalKey(),
                size: widget.size,
                onAnimationComplete: () {},
              ))
        ]),
        onDoubleTapDown: (details) {
          temp = _globalToLocal(details.globalPosition);
        },
        onDoubleTap: () {
          // 双击事件  双击刷新页面
          iconOffsets.add(temp);
          setState(() {
            // isFavorite = true;
          });
          // //延时
          // Future.delayed(Duration(milliseconds: 600), () {
          //   //(){} 闭包
          //   setState(() {
          //     // isFavorite = false;
          //   });
          // });
        });
  }
}
