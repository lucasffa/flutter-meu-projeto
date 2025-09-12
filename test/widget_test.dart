// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ifood_gestor/main.dart';

void main() {
  testWidgets('App initializes correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app initializer appears with a loading indicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Pump until the initialization is complete
    await tester.pumpAndSettle();

    // The app should navigate to login or dashboard page after initialization
    // (The exact destination depends on authentication state)
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
