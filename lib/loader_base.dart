import 'package:flutter/material.dart';

abstract class LoaderBase extends StatefulWidget {
  final double size;
  final Color? color;
  final Duration duration;
  final Gradient? gradient;
  final bool loop;

  const LoaderBase({
    super.key,
    required this.size,
    this.color,
    required this.duration,
    this.gradient,
    this.loop = true,
  });

  Widget buildLoader(BuildContext context, AnimationController controller);
}
