import 'package:baykurs/util/AllExtension.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'YOColors.dart';


class GlobalFadeAnimation extends StatefulWidget {
  final Duration duration;
  final double beginOpacity;
  final double endOpacity;

  const GlobalFadeAnimation({
    Key? key,
    this.duration = const Duration(seconds: 2),
    this.beginOpacity = 0.4,
    this.endOpacity = 1.0,
  }) : super(key: key);

  @override
  _GlobalFadeAnimationState createState() => _GlobalFadeAnimationState();
}

class _GlobalFadeAnimationState extends State<GlobalFadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(
      begin: widget.beginOpacity,
      end: widget.endOpacity,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withAlpha(60),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                'assets/loading_logo.png',
                // Burada animasyon uygulanacak resim veya widget
                width: 100,
                height: 100,
              ),
            ),
            24.toHeight,
            LoadingAnimationWidget.waveDots(
              color: color5,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
