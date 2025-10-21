import 'package:flutter/material.dart';
import '../loader_base.dart';

class FlippingSquaresLoader extends LoaderBase {
  const FlippingSquaresLoader({
    super.key,
    required super.size,
    super.color,
    required super.duration,
    super.gradient,
    super.loop,
  });

  @override
  State<FlippingSquaresLoader> createState() => _FlippingSquaresLoaderState();

  @override
  Widget buildLoader(BuildContext context, AnimationController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(2, (index) {
        return AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            double angle = controller.value * 2 * 3.1415 + (index * 3.1415 / 2);
            return Transform(
              transform: Matrix4.rotationY(angle),
              alignment: Alignment.center,
              child: Container(
                width: size * 0.4,
                height: size * 0.4,
                margin: EdgeInsets.symmetric(horizontal: size * 0.05),
                color: color ?? Colors.blue,
              ),
            );
          },
        );
      }),
    );
  }
}

class _FlippingSquaresLoaderState extends State<FlippingSquaresLoader>
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
