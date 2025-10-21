// all_in_one_loader.dart
import 'package:flutter/material.dart';
import 'loader_type.dart';
import 'loaders/circular_loader.dart';
import 'loaders/linear_loader.dart';
import 'loaders/dots_loader.dart';
import 'loaders/pulse_loader.dart';
import 'loaders/spinning_bars_loader.dart';
import 'loaders/wave_loader.dart';
import 'loaders/shimmer_loader.dart';
import 'loaders/flipping_squares_loader.dart';
import 'custom_loader.dart';
import 'loaders/shimmer_type.dart';

/// Typedef for custom loader builder
typedef LoaderBuilder = Widget Function(
  BuildContext context,
  AnimationController controller,
  Animation<double> progress,
);

/// Circular loader customization
class CircularLoaderConfig {
  final double? progress;
  final double strokeWidth;
  final bool showPercentage;
  final Color? backgroundColor;
  final Color? color;
  final StrokeCap strokeCap;

  const CircularLoaderConfig({
    this.progress,
    this.strokeWidth = 4.0,
    this.showPercentage = false,
    this.backgroundColor,
    this.color,
    this.strokeCap = StrokeCap.round,
  });
}

/// Linear loader customization
class LinearLoaderConfig {
  final double? progress;
  final double height;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;

  const LinearLoaderConfig({
    this.progress,
    this.height = 6.0,
    this.borderRadius,
    this.backgroundColor,
  });
}

/// Dots loader customization
class DotsLoaderConfig {
  final int count;
  final double dotSizeRatio;
  final double spacingRatio;
  final bool scaleAnimation;

  const DotsLoaderConfig({
    this.count = 3,
    this.dotSizeRatio = 0.2,
    this.spacingRatio = 0.05,
    this.scaleAnimation = true,
  });
}

/// Pulse loader customization
class PulseLoaderConfig {
  final int count;
  final double minScale;
  final double maxScale;
  final bool useGradient;

  const PulseLoaderConfig({
    this.count = 3,
    this.minScale = 0.5,
    this.maxScale = 1.0,
    this.useGradient = false,
  });
}

class AllInOneLoader extends StatelessWidget {
  final LoaderType type;
  final double size;
  final Color? color;
  final Duration duration;
  final Gradient? gradient;
  final bool loop;
  final bool showDemo;
  final ShimmerLayoutType? shimmerType;
  final LoaderBuilder? customBuilder;

  // Loader configs
  final CircularLoaderConfig? circularConfig;
  final LinearLoaderConfig? linearConfig;
  final DotsLoaderConfig? dotsConfig;
  final PulseLoaderConfig? pulseConfig;

  const AllInOneLoader({
    super.key,
    required this.type,
    this.size = 50.0,
    this.color,
    this.duration = const Duration(seconds: 1),
    this.gradient,
    this.loop = true,
    this.showDemo = false,
    this.customBuilder,
    this.shimmerType,
    this.circularConfig,
    this.linearConfig,
    this.dotsConfig,
    this.pulseConfig,
  });

  @override
  Widget build(BuildContext context) {
    if (showDemo) {
      return Wrap(
        spacing: 20,
        runSpacing: 20,
        children: LoaderType.values.map((loaderType) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AllInOneLoader(type: loaderType, size: 40),
              const SizedBox(height: 8),
              Text(loaderType.toString().split('.').last),
            ],
          );
        }).toList(),
      );
    }

    switch (type) {
      case LoaderType.circular:
        return CircularLoader(
          size: size,
          color: circularConfig?.color ?? color,
          duration: duration,
          loop: loop,
          progress: circularConfig?.progress,
          strokeWidth: circularConfig?.strokeWidth ?? 4.0,
          showPercentage: circularConfig?.showPercentage ?? false,
          backgroundColor: circularConfig?.backgroundColor,
          strokeCap: circularConfig?.strokeCap ?? StrokeCap.round,
          gradient: gradient,
        );

      case LoaderType.linear:
        return LinearLoader(
          size: size,
          color: color,
          duration: duration,
          loop: loop,
          progress: linearConfig?.progress,
          strokeWidth: linearConfig?.height ?? 6.0,
          backgroundColor: linearConfig?.backgroundColor,
          borderRadius: linearConfig?.borderRadius,
          gradient: gradient,
        );

      case LoaderType.dots:
        return DotsLoader(
          size: size,
          color: color,
          duration: duration,
          loop: loop,
          dotCount: dotsConfig?.count ?? 3,
          dotSizeRatio: dotsConfig?.dotSizeRatio ?? 0.2,
          spacingRatio: dotsConfig?.spacingRatio ?? 0.05,
          scaleAnimation: dotsConfig?.scaleAnimation ?? true,
          gradient: gradient,
        );

      case LoaderType.pulse:
        return PulseLoader(
          size: size,
          color: color,
          duration: duration,
          loop: loop,
          pulseCount: pulseConfig?.count ?? 3,
          minScale: pulseConfig?.minScale ?? 0.5,
          maxScale: pulseConfig?.maxScale ?? 1.0,
          gradient: gradient,
          useGradient: pulseConfig?.useGradient ?? false,
        );

      case LoaderType.spinningBars:
        return SpinningBarsLoader(
          size: size,
          color: color,
          duration: duration,
          loop: loop,
          gradient: gradient,
        );

      case LoaderType.wave:
        return WaveLoader(
          size: size,
          color: color,
          duration: duration,
          loop: loop,
          gradient: gradient,
        );

      case LoaderType.shimmer:
        return ShimmerLoader(
          size: size,
          color: color,
          duration: duration,
          loop: loop,
          layoutType: shimmerType ?? ShimmerLayoutType.card,
        );

      case LoaderType.flippingSquares:
        return FlippingSquaresLoader(
          size: size,
          color: color,
          duration: duration,
          loop: loop,
          gradient: gradient,
        );

      case LoaderType.custom:
        return CustomLoader(
          size: size,
          color: color,
          duration: duration,
          loop: loop,
          builder: customBuilder ??
              (context, controller, progress) => RotationTransition(
                    turns: progress,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: color ?? Colors.purple,
                        borderRadius: BorderRadius.circular(size * 0.2),
                      ),
                    ),
                  ),
        );
    }
  }
}
