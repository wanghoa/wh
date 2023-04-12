import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteAnimationIcon extends StatefulWidget {
  final double size;

  const FavoriteAnimationIcon({required Key key ,required this.size}):super(key: key); //  此处是否添加 const 从代码表面看没什么区别；

  @override
  State<FavoriteAnimationIcon> createState() => _FavoriteAnimationIconState();
}

class _FavoriteAnimationIconState extends State<FavoriteAnimationIcon> with TickerProviderStateMixin{
  late AnimationController _animationController;
  static const int _duration = 600; // 动画时长
  _FavoriteAnimationIconState();

  @override
  void initState() {
    super.initState();
    _animationController =  AnimationController(duration: const Duration(milliseconds: _duration), vsync: this);// this ->TickerProviderStateMixin
  }

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.favorite, size: widget.size, color: Colors.redAccent);
  }
}
