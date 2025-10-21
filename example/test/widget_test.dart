import 'package:all_in_one_loader/custom_loader.dart';
import 'package:all_in_one_loader/loaders/circular_loader.dart';
import 'package:all_in_one_loader/loaders/dots_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:all_in_one_loader/all_in_one_loader.dart';
import 'package:all_in_one_loader/loader_type.dart';

void main() {
  testWidgets('AllInOneLoader renders CircularLoader', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AllInOneLoader(type: LoaderType.circular, size: 50),
        ),
      ),
    );

    expect(find.byType(AllInOneLoader), findsOneWidget);
    expect(find.byType(CircularLoader), findsOneWidget);
  });

  testWidgets('AllInOneLoader renders DotsLoader', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AllInOneLoader(type: LoaderType.dots, size: 40)),
      ),
    );

    expect(find.byType(DotsLoader), findsOneWidget);
  });

  testWidgets('AllInOneLoader custom size and color', (
    WidgetTester tester,
  ) async {
    const testColor = Colors.red;
    const testSize = 60.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AllInOneLoader(
            type: LoaderType.circular,
            size: testSize,
            color: testColor,
          ),
        ),
      ),
    );

    final loader = tester.widget<AllInOneLoader>(find.byType(AllInOneLoader));
    expect(loader.size, testSize);
    expect(loader.color, testColor);
  });

  testWidgets('CustomLoader works', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AllInOneLoader(
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
                              color:
                                  Colors.primaries[i % Colors.primaries.length],
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
        ),
      ),
    );

    expect(find.byType(CustomLoader), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(3));
  });
}
