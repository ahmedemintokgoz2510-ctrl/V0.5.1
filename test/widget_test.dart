// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:crazy_block_online/main.dart';

void main() {
  testWidgets('Crazy Block Online - App Launch Test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CrazyBlockOnlineApp());

    // Verify that the loading screen or login screen is displayed
    // The app should show some UI after launch
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Loading Screen Test', (WidgetTester tester) async {
    await tester.pumpWidget(const CrazyBlockOnlineApp());

    // Wait for the widget to be built
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Verify some widget is present
    expect(find.byType(Scaffold), findsWidgets);
  });
}
