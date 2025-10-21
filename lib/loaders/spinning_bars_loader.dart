import 'package:flutter/material.dart';
import '../loader_base.dart';

class SpinningBarsLoader extends LoaderBase {
  const SpinningBarsLoader({
    super.key,
    required super.size,
    super.color,
    required super.duration,
    super.gradient,
    super.loop,
  });

  @override
  State<SpinningBarsLoader> createState() => _SpinningBarsLoaderState();

  @override
  Widget buildLoader(BuildContext context, AnimationController controller) {
    return RotationTransition(
      turns: controller,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          return Container(
            width: size * 0.2,
            height: size,
            margin: EdgeInsets.symmetric(horizontal: size * 0.05),
            color: color ?? Colors.blue,
          );
        }),
      ),
    );
  }
}

class _SpinningBarsLoaderState extends State<SpinningBarsLoader>
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
