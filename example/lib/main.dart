import 'package:flutter/material.dart';
import 'package:all_in_one_loader/all_in_one_loader.dart';
import 'package:all_in_one_loader/loader_type.dart';

void main() {
  runApp(const LoaderDemoApp());
}

class LoaderDemoApp extends StatelessWidget {
  const LoaderDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'All In One Loader Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoaderDemoScreen(),
    );
  }
}

class LoaderDemoScreen extends StatelessWidget {
  const LoaderDemoScreen({super.key});

  final double loaderSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All In One Loader Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: LoaderType.values.map((loaderType) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AllInOneLoader(
                      type: loaderType,
                      size: loaderSize,
                      color: loaderType == LoaderType.shimmer
                          ? Colors.grey
                          : Colors.blue,
                      duration: const Duration(seconds: 1),
                    ),
                    const SizedBox(height: 8),
                    Text(loaderType.toString().split('.').last),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            const Text(
              'Custom Loader Example',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            AllInOneLoader(
              type: LoaderType.custom,
              size: 80,
              color: Colors.blueAccent,
              duration: const Duration(seconds: 2),
              loop: true,
              customBuilder: (context, controller, progress) {
                return AnimatedBuilder(
                  animation: progress,
                  builder: (_, __) {
                    final double value = progress.value;
                    return Stack(
                      alignment: Alignment.center,
                      children: List.generate(3, (i) {
                        final offset = (i - 1) * 30.0;
                        return Transform.translate(
                          offset: Offset(
                            offset,
                            (1 - value) * 20 * (i % 2 == 0 ? 1 : -1),
                          ),
                          child: Opacity(
                            opacity: 0.5 + 0.5 * value,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors
                                    .primaries[i % Colors.primaries.length],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
