### All In One Loader

A fully customizable, all-in-one loader widget for Flutter.
Includes multiple loader types (circular, linear, dots, pulse, spinning bars, wave, shimmer, flipping squares) and first-class support for custom animations, gradients, determinate progress, and small per-loader config objects to keep the API tidy.


![All In One Loader Demo](assets/all_in_one_loaders.gif)


### Installation (from pub.dev)

Add the package to your app pubspec.yaml dependencies:

```bash
dependencies:
  all_in_one_loader: ^0.0.2
```
Then fetch packages:

```bash
flutter pub get
```
Import in your Dart files:

```bash
import 'package:all_in_one_loader/all_in_one_loader.dart';
import 'package:all_in_one_loader/loader_type.dart';
```

### Quick usage

```bash
AllInOneLoader(
  type: LoaderType.circular,
  size: 80,
  color: Colors.blue,
  duration: Duration(seconds: 2),
  circularConfig: const CircularLoaderConfig(
    strokeWidth: 6.0,
    showPercentage: true,
  ),
);
```

### Overview of the widget

AllInOneLoader is the single entry point:

```bash
AllInOneLoader({
  required LoaderType type,
  double size = 50.0,
  Color? color,
  Duration duration = const Duration(seconds: 1),
  Gradient? gradient,
  bool loop = true,
  bool showDemo = false,
  ShimmerLayoutType? shimmerType,
  LoaderBuilder? customBuilder,
  CircularLoaderConfig? circularConfig,
  LinearLoaderConfig? linearConfig,
  DotsLoaderConfig? dotsConfig,
  PulseLoaderConfig? pulseConfig,
})
```
- type — which loader to render (see LoaderType enum).

- size — width/height used by most loaders.

- color — base color for loaders that use a single color.

- gradient — gradient to apply when a loader supports it.

- duration — animation cycle length.

- loop — true for repeating animation; set false if you want it to run once.

- showDemo — shows all loaders (handy for documentation screens).

- customBuilder — provide custom animation with access to the AnimationController.

- Per-loader config objects (described below) let you fine-tune behavior.

### Per-loader configs & detailed API

All config classes are immutable and simple to construct. Use them to keep your AllInOneLoader call compact.

### Circular loader — CircularLoaderConfig

```bash
const CircularLoaderConfig({
  double? progress,          // 0.0 - 1.0; if set, loader is determinate
  double strokeWidth = 4.0,
  bool showPercentage = false,
  Color? backgroundColor,    // track color (behind the progress)
  Color? color,              // overrides top-level color if provided
  StrokeCap strokeCap = StrokeCap.round,
});

```
Notes & examples

 - Indeterminate spinner (default):
     - 
```bash
    AllInOneLoader(type: LoaderType.circular, size: 60);
```
 - Determinate with percentage:
     - 
```bash
    AllInOneLoader(
        type: LoaderType.circular,
        size: 100,
        circularConfig: const CircularLoaderConfig(
        progress: 0.65,
        strokeWidth: 8.0,
        showPercentage: true,
        backgroundColor: Colors.grey,
        ),
    );
```
 - Gradient: pass a gradient in AllInOneLoader and the loader will use the gradient where supported:

```bash
    AllInOneLoader(
        type: LoaderType.circular,
        gradient: LinearGradient(colors: [Colors.pink, Colors.purple]),
    );
```

### Linear loader — LinearLoaderConfig

```bash
const LinearLoaderConfig({
  double? progress,
  double height = 6.0,
  BorderRadius? borderRadius,
  Color? backgroundColor,
});
```

Examples

- Indeterminate:
 ```bash
     AllInOneLoader(type: LoaderType.linear, size: 180 /* width */);
 ```
- Determinate with rounded corners:
 ```bash
     AllInOneLoader(
        type: LoaderType.linear,
        size: 240,
        color: Colors.blue,
        linearConfig: const LinearLoaderConfig(
        progress: 0.45,
        height: 10.0,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        backgroundColor: Colors.grey,
        ),
    );
 ```
- Gradient:
 ```bash
     AllInOneLoader(
        type: LoaderType.linear,
        size: 240,
        gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
    );
 ```

### Dots loader — DotsLoaderConfig

```bash
const DotsLoaderConfig({
  int count = 3,
  double dotSizeRatio = 0.2,   // fraction of `size`
  double spacingRatio = 0.05,  // fraction of `size`
  bool scaleAnimation = true,
});
```

Examples

- Default three dots:
```bash
    AllInOneLoader(type: LoaderType.dots, size: 50);
```
- Four larger dots:
```bash
    AllInOneLoader(
        type: LoaderType.dots,
        size: 60,
        dotsConfig: const DotsLoaderConfig(count: 4, dotSizeRatio: 0.25, spacingRatio: 0.08),
        gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
    );
```

### Pulse loader — PulseLoaderConfig

```bash
const PulseLoaderConfig({
  int count = 3,          // overlapping pulses
  double minScale = 0.5,
  double maxScale = 1.0,
  bool useGradient = false,
});
```

Examples

- Single circle pulsing (default count is 3, overlapping pulses produce the effect):

```bash
AllInOneLoader(type: LoaderType.pulse, size: 80, color: Colors.teal);
```
- Gradient pulse:
```bash
AllInOneLoader(
  type: LoaderType.pulse,
  size: 90,
  pulseConfig: const PulseLoaderConfig(count: 4, minScale: 0.4, maxScale: 1.2, useGradient: true),
  gradient: const LinearGradient(colors: [Colors.green, Colors.orange]),
);
```

### Shimmer loader

AllInOneLoader exposes shimmerType (the ShimmerLayoutType) — choose layout templates such as card, list, grid:

```bash
AllInOneLoader(
  type: LoaderType.shimmer,
  size: 80,
  shimmerType: ShimmerLayoutType.profile,
  color: Colors.grey,
  duration: Duration(seconds: 2),
);
```
Shimmer loader renders skeleton layouts (avatar+lines, list rows, card blocks, grid tiles). Use size to influence the base sizing.


### Spinning bars, Wave, Flipping Squares

These loader types accept the shared arguments (size, color, gradient, duration, loop) and behave similarly to their namesakes. Use gradient to apply multi-color effects where supported.

### Custom loader — customBuilder (advanced)

Type:

```bash
typedef LoaderBuilder = Widget Function(
  BuildContext context,
  AnimationController controller,
  Animation<double> progress,
);
```
- controller: AnimationController controlled by duration and loop. Use it if you need fine-grained control (e.g., coordinate multiple animations).

- progress: a convenient Animation<double> (often a CurvedAnimation) you can use directly in AnimatedBuilder or AnimatedWidget.

Best practices & example

- Keep the builder lightweight — create only the widgets you need.
- Use AnimatedBuilder driven by progress or controller.
- Prefer progress for simpler timing and curves.

Example — multi-dot custom animation:

```bash
AllInOneLoader(
  type: LoaderType.custom,
  size: 80,
  duration: const Duration(seconds: 2),
  loop: true,
  customBuilder: (context, controller, progress) {
    return AnimatedBuilder(
      animation: progress,
      builder: (_, __) {
        final v = progress.value;
        return Stack(
          alignment: Alignment.center,
          children: List.generate(3, (i) {
            final offset = (i - 1) * 24.0;
            return Transform.translate(
              offset: Offset(offset, (1 - v) * 20 * (i % 2 == 0 ? 1 : -1)),
              child: Opacity(
                opacity: 0.5 + 0.5 * v,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.primaries[i % Colors.primaries.length],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  },
);
```

### Gradient usage rules

- Pass a gradient to AllInOneLoader when you want a gradient effect.
- Not all loaders use gradients the same way — where gradient is supported, the loader will prefer gradient over color.
- For background or track colors, use the config fields like backgroundColor (e.g., CircularLoaderConfig.backgroundColor).


### Practical tips

- Determinate vs Indeterminate: For determinate loaders, set progress in the relevant config. Use loop: false if you want the animation to complete once.
- Sizing: For circular loaders, size is outer container size; stroke and inner indicator adapt automatically. For linear loader, size is treated as width.
- Text inside loaders: CircularLoader supports showPercentage to draw the numeric progress. It scales to fit.
- Demo UI: Use showDemo: true to quickly display a grid of all loaded types for documentation pages or design reviews.

### Example app (included)

A full example is included inside the example/ folder. To run it (after adding package via pub.dev in your app — or if you clone the repo and want to test the local package, use the example's pubspec with a path dependency):

```bash
cd example
flutter pub get
flutter run
```
The example/ demonstrates all loader types and includes a custom builder example.









