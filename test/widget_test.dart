import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:college_project/main.dart'; // Update with your actual project file

void main() {
  testWidgets('Login screen test', (WidgetTester tester) async {
    // Load the app
    await tester.pumpWidget(RestaurantApp());

    // Verify login screen UI elements
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);

    // Enter email & password
    await tester.enterText(
        find.byType(TextFormField).at(0), 'mailpradeep673@gmail.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'Pradeep@2003');

    // Tap login button
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle(); // Wait for navigation

    // Check if navigated to Table Selection screen
    expect(find.text('Select Table'), findsOneWidget);
  });
}
