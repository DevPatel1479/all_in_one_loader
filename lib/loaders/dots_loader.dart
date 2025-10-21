import 'package:flutter/material.dart';
import '../loader_base.dart';

class DotsLoader extends LoaderBase {
  final int dotCount;
  final double dotSizeRatio; // relative to size
  final double spacingRatio; // relative to size
  final bool scaleAnimation; // add scaling effect

  const DotsLoader({
    super.key,
    required super.size,
    super.color,
    required super.duration,
    super.gradient,
    super.loop,
    this.dotCount = 3,
    this.dotSizeRatio = 0.2,
    this.spacingRatio = 0.05,
    this.scaleAnimation = true,
  });

  @override
  State<DotsLoader> createState() => _DotsLoaderState();

  @override
  Widget buildLoader(BuildContext context, AnimationController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(dotCount, (index) {
        return AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            double opacity = ((controller.value + index * 0.3) % 1.0);
            double scale = scaleAnimation ? 0.5 + 0.5 * opacity : 1.0;
            return Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: size * dotSizeRatio,
                  height: size * dotSizeRatio,
                  margin: EdgeInsets.symmetric(horizontal: size * spacingRatio),
                  decoration: BoxDecoration(
                    color: color ?? Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class _DotsLoaderState extends State<DotsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    widget.loop ? _controller.repeat() : _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.buildLoader(context, _controller);
  }
}
