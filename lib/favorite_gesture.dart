import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteGesture extends StatefulWidget {
  final Widget child;

  const FavoriteGesture({required this.child, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoriteGestureState();
}

class _FavoriteGestureState extends State<FavoriteGesture> {
  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Stack(// 堆叠（FrameLayout）
            children: [
          Container(width: double.infinity, color: Colors.black),
          if (isFavorite)
            //默认 Icon 不显示
            const Icon(Icons.favorite, size: 100, color: Colors.redAccent)
        ]),
        onDoubleTap: () {
          // 双击事件  双击刷新页面
          setState(() {

          });

        });
  }
}
