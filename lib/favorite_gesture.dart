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
    var iconStack = Stack(
        children: // 堆积效果使用Stack 多红心堆叠；渲染逻辑， 使用map进行遍历
            iconOffsets
                .map((e) => FavoriteAnimationIcon(
                      // e: 每个坐标集合
                      key: Key(e.toString()),
                      size: widget.size,
                      position: e,
                      onAnimationComplete: () {
                        iconOffsets.remove(e); // 动画完成 进行移除
                      },
                    ))
                .toList());

    return GestureDetector(
        key: _key,
        child: Stack(// 堆叠（FrameLayout）
            children: [
          // VideoView  //child:VideoView
          widget.child,
          // Container(width: double.infinity, color: Colors.black),// 这里Container 代替VideoView;
          iconStack
        ]),
        onDoubleTapDown: (details) {
          temp = _globalToLocal(details.globalPosition);
        },
        onDoubleTap: () {
          // 双击事件  双击刷新页面
          setState(() =>
              iconOffsets.add(temp)); // 添加到坐标集合，触发一次重绘，根据坐标集合来在不同的坐标上渲染icon
          // //延时  注释掉 通过动画完成
          // Future.delayed(Duration(milliseconds: 600), () {
          //   //(){} 闭包
          //   setState(() {
          //     // isFavorite = false;
          //   });
          // });
        });
  }
}
