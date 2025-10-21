import 'package:flutter/material.dart';
import '../loader_base.dart';

class PulseLoader extends LoaderBase {
  final int pulseCount; // Number of overlapping pulses
  final double minScale; // Minimum scale
  final double maxScale; // Maximum scale
  final bool useGradient; // Enable gradient effect

  const PulseLoader({
    super.key,
    required super.size,
    super.color,
    required super.duration,
    super.gradient,
    super.loop,
    this.pulseCount = 3,
    this.minScale = 0.5,
    this.maxScale = 1.0,
    this.useGradient = false,
  });

  @override
  State<PulseLoader> createState() => _PulseLoaderState();

  @override
  Widget buildLoader(BuildContext context, AnimationController controller) {
    return ScaleTransition(
      scale: Tween(
        begin: minScale,
        end: maxScale,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: useGradient == true ? null : color ?? Colors.blue,
          gradient: useGradient == true ? gradient : null,
        ),
      ),
    );
  }
}

class _PulseLoaderState extends State<PulseLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    widget.loop ? _controller.repeat(reverse: true) : _controller.forward();
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
