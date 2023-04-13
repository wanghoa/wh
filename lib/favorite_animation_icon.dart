import 'dart:math';

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

  final double angle =
      pi / 10 * (2 * Random().nextDouble() - 1); // 创建时就已确定不会再修改它加上final
  // double get angle => pi / 10 * (2 * Random().nextDouble() - 1);

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
    // Transform.translate(offset: offset)// 平移动画
    var content =
        Icon(Icons.favorite, size: widget.size, color: Colors.redAccent);
    // 特效优化 实现渐变效果
    var child = ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (Rect bounds) => RadialGradient(colors: [
              Color(0XFFEE6E6E),
              Color(0XFFF03F3F)
            ], center: Alignment.topLeft.add(const Alignment(0.66, 0.66))) // 方向
                .createShader(bounds),
        child: Transform.rotate(
            angle: angle,
            child: Transform.scale(
                scale: scale,
                alignment: Alignment.bottomCenter,
                child: content)));

    ; //随机角度 旋转动画 + 缩放动画

    return Positioned(
        top: widget.position.dy - widget.size! / 2,
        left: widget.position.dx - widget.size! / 2,
        child: Opacity(opacity: opacity, child: child)); // 透明度动画
  }

  /// 需要得到的结果，是透明度的进度值百分比
  double get opacity {
    if (value < appearValue) {
      // 处于渐进阶段。播放透明度动画
      return value / appearValue; //
    }
    if (value < dismissValue) {
      return 1; // 展示阶段,不需要动画
    }
    // 渐隐阶段，
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

  // 计算缩放动画尺寸
  double get scale {
    if (value < appearValue) {
      // 处于出现阶段
      return 1 + appearValue - value;
    }
    if (value < dismissValue) {
      // 正常展示阶段
      return 1;
    }
    // 消失放大阶段
    return 1 + (value - dismissValue) / (1 - dismissValue);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose(); //回收资源
  }
}
