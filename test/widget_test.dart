import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/controllers/auth_controller.dart';
import 'package:restaurant_app/controllers/cart_controller.dart';

void main() {
  testWidgets('App basic navigation test', (WidgetTester tester) async {
    // Register controllers for test environment
    Get.put(AuthController());
    Get.put(CartController());

    // Build the app
    await tester.pumpWidget(MyApp());

    // Verify SplashScreen shows
    expect(find.text('Restaurant App'), findsOneWidget);

    // Wait 2 seconds for splash delay
    await tester.pumpAndSettle(Duration(seconds: 2));

    // Verify LoginScreen shows
    expect(find.widgetWithText(AppBar, 'Login'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    expect(find.text("Don't have an account? Sign Up"), findsOneWidget);

    // Enter hardcoded credentials
    await tester.enterText(find.byType(TextField).first, 'admin');
    await tester.enterText(find.byType(TextField).last, '12345');

    // Tap Login button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    // HomeScreen should appear
    // Check for at least one menu item price text
    expect(find.textContaining('Price'), findsWidgets);
  });
}
