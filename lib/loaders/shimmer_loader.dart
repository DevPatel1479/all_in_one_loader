import 'package:all_in_one_loader/loaders/shimmer_type.dart';
import 'package:flutter/material.dart';
import '../loader_base.dart';

class ShimmerLoader extends LoaderBase {
  final ShimmerLayoutType layoutType;

  const ShimmerLoader({
    super.key,
    required super.size,
    super.color,
    required super.duration,
    super.gradient,
    super.loop,
    this.layoutType = ShimmerLayoutType.card,
  });

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();

  @override
  Widget buildLoader(BuildContext context, AnimationController controller) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => _buildShimmerLayout(context, controller),
    );
  }

  Widget _buildShimmerLayout(
    BuildContext context,
    AnimationController controller,
  ) {
    final baseColor = (color ?? Colors.grey);
    final gradient = LinearGradient(
      colors: [
        baseColor.withAlpha((0.3 * 255).toInt()),
        baseColor.withAlpha((0.7 * 255).toInt()),
        baseColor.withAlpha((0.3 * 255).toInt()),
      ],
      stops: [controller.value - 0.3, controller.value, controller.value + 0.3],
      begin: Alignment(-1, -0.3),
      end: Alignment(1, 0.3),
    );

    switch (layoutType) {
      case ShimmerLayoutType.list:
        return _listShimmer(gradient);
      case ShimmerLayoutType.grid:
        return _gridShimmer(gradient);
      case ShimmerLayoutType.card:
        return _cardShimmer(gradient);
    }
  }

  Widget _cardShimmer(Gradient gradient) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: size * 2,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _listShimmer(Gradient gradient) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(5, (i) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          height: size * 0.8,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }

  Widget _gridShimmer(Gradient gradient) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(6, (i) {
        return Container(
          width: size * 1.5,
          height: size * 1.5,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}

class _ShimmerLoaderState extends State<ShimmerLoader>
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
