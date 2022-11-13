import 'package:cleanarch/presentation/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// widget test
void main() {
  testWidgets("Should have a title", (WidgetTester tester) async {

    // Arrange
    // load a widget in test file
    // pumpWidget is Future so should be await
    await tester.pumpWidget(const MaterialApp(
      home: LoginView(),
    ));

    // Act
    Finder title = find.text("Login");

    // Assert
    expect(title, findsOneWidget);
  });
}
