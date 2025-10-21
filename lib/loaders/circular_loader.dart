import 'package:flutter/material.dart';
import '../loader_base.dart';

class CircularLoader extends LoaderBase {
  final double? progress; // 0.0–1.0
  final double? strokeWidth;
  final bool showPercentage;
  final Color? backgroundColor;
  final StrokeCap strokeCap;

  const CircularLoader({
    super.key,
    required super.size,
    super.color,
    required super.duration,
    super.gradient,
    super.loop,
    this.progress,
    this.strokeWidth,
    this.showPercentage = false,
    this.backgroundColor,
    this.strokeCap = StrokeCap.round,
  });

  @override
  State<CircularLoader> createState() => _CircularLoaderState();

  @override
  Widget buildLoader(BuildContext context, AnimationController controller) {
    final double actualStrokeWidth = strokeWidth ?? size * 0.08;
    final double indicatorSize = size - actualStrokeWidth * 2;
    final animatedValue = progress ?? controller.value;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: indicatorSize,
            height: indicatorSize,
            child: CircularProgressIndicator(
              value: loop ? null : animatedValue,
              strokeWidth: actualStrokeWidth,
              backgroundColor: backgroundColor?.withAlpha((0.2 * 255).toInt()),
              color: color ?? Colors.blue,
              strokeCap: strokeCap,
              valueColor: gradient != null
                  ? AlwaysStoppedAnimation<Color>(gradient!.colors.first)
                  : null,
            ),
          ),
          if (showPercentage)
            Text(
              "${(animatedValue * 100).toInt()}%",
              style: TextStyle(
                color: color ?? Colors.black,
                fontSize: indicatorSize * 0.3, // text scales with inner radius
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}

class _CircularLoaderState extends State<CircularLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    if (widget.loop) {
      _controller.repeat();
    } else {
      if (widget.progress == null) _controller.forward();
    }
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
