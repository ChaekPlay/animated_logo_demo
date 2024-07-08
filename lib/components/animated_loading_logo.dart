import 'package:flutter/material.dart';

class AnimatedLoadingDemo extends StatefulWidget {
  const AnimatedLoadingDemo({
    super.key,
    this.duration = const Duration(milliseconds: 2000),
    this.displayText = "Loading",
  });
  final Duration duration;
  final String displayText;

  @override
  State<AnimatedLoadingDemo> createState() => _AnimatedLoadingDemoState();
}

class _AnimatedLoadingDemoState extends State<AnimatedLoadingDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _sizeAnimation;
  late Animation<int> _dotsCount;
  late Animation<Color?> _cloudColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _sizeAnimation = Tween<double>(
      begin: 100,
      end: 200,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.25,
          1,
          curve: Curves.easeInOutCubicEmphasized,
        ),
      ),
    );
    _dotsCount = IntTween(
      begin: 0,
      end: 3,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _cloudColor = ColorTween(
      begin: Colors.orange,
      end: Colors.blue,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.35, curve: Curves.linear),
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Icon(
                  Icons.cloud,
                  size: _sizeAnimation.value,
                  color: _cloudColor.value,
                ),
              ),
              Text(
                "${widget.displayText}${"." * _dotsCount.value}",
                style: const TextStyle(fontSize: 24),
              )
            ],
          );
        });
  }
}
