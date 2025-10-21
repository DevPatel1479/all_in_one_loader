import 'package:flutter/material.dart';
import 'loader_base.dart';

class CustomLoader extends LoaderBase {
  /// The builder now provides both the [AnimationController]
  /// and a [progress] animation for complex usage.
  final Widget Function(BuildContext, AnimationController, Animation<double>)
  builder;

  const CustomLoader({
    super.key,
    required this.builder,
    required super.size,
    super.color,
    required super.duration,
    super.gradient,
    super.loop,
  });

  @override
  State<CustomLoader> createState() => _CustomLoaderState();

  @override
  Widget buildLoader(BuildContext context, AnimationController controller) {
    final progress = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
    return builder(context, controller, progress);
  }
}

class _CustomLoaderState extends State<CustomLoader>
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
    final progress = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    return widget.builder(context, _controller, progress);
  }
}
