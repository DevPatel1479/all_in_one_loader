import 'package:flutter/material.dart';
import '../loader_base.dart';

class LinearLoader extends LoaderBase {
  final double? progress; // 0.0–1.0 (determinate mode)
  final double strokeWidth; // height of the bar
  final bool showPercentage; // show text
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  const LinearLoader({
    super.key,
    required super.size,
    super.color,
    required super.duration,
    super.gradient,
    super.loop,
    this.progress,
    this.strokeWidth = 6.0,
    this.showPercentage = false,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  State<LinearLoader> createState() => _LinearLoaderState();

  @override
  Widget buildLoader(BuildContext context, AnimationController controller) {
    final animatedValue = progress ?? controller.value;

    return SizedBox(
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius:
                borderRadius ?? BorderRadius.circular(strokeWidth / 2),
            child: LinearProgressIndicator(
              value: loop ? null : animatedValue,
              color: color ?? Colors.blue,
              backgroundColor: backgroundColor?.withAlpha((0.2 * 255).toInt()),
              minHeight: strokeWidth,
              valueColor: gradient != null
                  ? AlwaysStoppedAnimation<Color>(gradient!.colors.first)
                  : null,
            ),
          ),
          if (showPercentage)
            Positioned.fill(
              child: Center(
                child: Text(
                  "${(animatedValue * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: strokeWidth * 1.2,
                    fontWeight: FontWeight.bold,
                    color: color ?? Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LinearLoaderState extends State<LinearLoader>
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
