import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteAnimationIcon extends StatefulWidget {
  final Offset position;

  ///保存每个坐标
  final double size;
  final Function? onAnimationComplete;

  const FavoriteAnimationIcon(
      {required Key key,
      required this.size,
      required this.position,
      this.onAnimationComplete})
      : super(key: key); //  此处是否添加 const 从代码表面看没什么区别；

  @override
  State<FavoriteAnimationIcon> createState() => _FavoriteAnimationIconState();
}

class _FavoriteAnimationIconState extends State<FavoriteAnimationIcon>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  static const int _duration = 600; // 动画时长
  // 展示的进度值
  static const double appearValue = 0.1;

  // 消失的进度值
  static const double dismissValue = 0.8;

  _FavoriteAnimationIconState();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: _duration),
        vsync: this); // this ->TickerProviderStateMixin
    // 监听进度
    _animationController.addListener(() {
      setState(() {}); // 重绘
    });

    // 开始动画逻辑
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    var content =
        Icon(Icons.favorite, size: widget.size, color: Colors.redAccent);
    return Positioned(
        top: widget.position.dy - widget.size! / 2,
        left: widget.position.dx - widget.size! / 2,
        child: Opacity(opacity: opacity, child: content)); // 透明度动画
  }

  /// 需要得到的结果，是透明度的进度值百分比
  double get opacity {
    if (value < appearValue) {
      // 处于渐进阶段。播放透明度动画
      return value / appearValue; //
    }
    if (value < dismissValue) {
      return 1; // 不需要动画
    }
    return (1 - value) / (1 - dismissValue);
  }

  double get value {
    return _animationController.value;
  }

  void startAnimation() async {
    await _animationController.forward();

    /// await 是同步方法 动画播放完成才会向下执行代码
    widget.onAnimationComplete?.call();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose(); //回收资源
  }
}
