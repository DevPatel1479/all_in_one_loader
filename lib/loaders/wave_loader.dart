import 'package:flutter/material.dart';
import '../loader_base.dart';

class WaveLoader extends LoaderBase {
  const WaveLoader({
    super.key,
    required super.size,
    super.color,
    required super.duration,
    super.gradient,
    super.loop,
  });

  @override
  State<WaveLoader> createState() => _WaveLoaderState();

  @override
  Widget buildLoader(BuildContext context, AnimationController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            double offset = (controller.value + index * 0.3) % 1.0;
            return Container(
              width: size * 0.2,
              height: size * 0.5 * (0.5 + offset),
              margin: EdgeInsets.symmetric(horizontal: size * 0.05),
              decoration: BoxDecoration(
                color: color ?? Colors.blue,
                borderRadius: BorderRadius.circular(size * 0.05),
              ),
            );
          },
        );
      }),
    );
  }
}

class _WaveLoaderState extends State<WaveLoader>
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
