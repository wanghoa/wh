import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteGesture extends StatefulWidget {
  final Widget child;

  const FavoriteGesture(this.child,  {Key? key}):super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoriteGestureState();
}

class _FavoriteGestureState extends State<FavoriteGesture> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(// 堆叠（FrameLayout）
        children: [
      Container(width: double.infinity, color: Colors.black),
      const Icon(Icons.favorite, size: 100, color: Colors.redAccent)
    ]);
  }
}
