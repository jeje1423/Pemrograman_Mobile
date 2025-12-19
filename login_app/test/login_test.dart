import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/login_page.dart';

void main() {
  testWidgets('Login page renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Verify that the login title appears.
    expect(find.text('Login'), findsOneWidget);
    
    // Verify that email field exists.
    expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    
    // Verify that password field exists.
    expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    
    // Verify that remember me checkbox exists.
    expect(find.text('Remember me'), findsOneWidget);
    
    // Verify that login button exists.
    expect(find.text('LOGIN'), findsOneWidget);
  });

  testWidgets('Toggle password visibility', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Initially, should show visibility_off icon (password hidden)
    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    expect(find.byIcon(Icons.visibility_outlined), findsNothing);

    // Find and tap the visibility icon
    final visibilityIcon = find.byType(IconButton).last;
    await tester.tap(visibilityIcon);
    await tester.pump();

    // After tapping, should show visibility icon (password visible)
    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off_outlined), findsNothing);
  });

  testWidgets('Remember me checkbox toggles', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Initially checkbox should be unchecked
    final checkbox = find.byType(Checkbox);
    Checkbox checkboxWidget = tester.widget(checkbox);
    expect(checkboxWidget.value, isFalse);

    // Tap the checkbox
    await tester.tap(find.text('Remember me'));
    await tester.pump();

    // Now checkbox should be checked
    checkboxWidget = tester.widget(checkbox);
    expect(checkboxWidget.value, isTrue);
  });

  testWidgets('Email validation shows error for invalid email', 
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Find email field and enter invalid email
    final emailField = find.byType(TextFormField).first;
    await tester.enterText(emailField, 'invalid-email');
    
    // Find and tap the login button to trigger validation
    await tester.tap(find.text('LOGIN'));
    await tester.pump();

    // Should show validation error
    expect(find.text('Format email tidak valid'), findsOneWidget);
  });

  testWidgets('Password validation shows error for short password', 
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Find password field and enter short password
    final passwordField = find.byType(TextFormField).last;
    await tester.enterText(passwordField, '123');
    
    // Find and tap the login button to trigger validation
    await tester.tap(find.text('LOGIN'));
    await tester.pump();

    // Should show validation error
    expect(find.text('Password minimal 6 karakter'), findsOneWidget);
  });

  testWidgets('Loading state shows when login button is pressed', 
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Enter valid credentials
    final emailField = find.byType(TextFormField).first;
    final passwordField = find.byType(TextFormField).last;
    
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password123');
    
    // Tap login button
    await tester.tap(find.text('LOGIN'));
    await tester.pump();

    // Should show loading indicator
    expect(find.text('Memproses...'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}