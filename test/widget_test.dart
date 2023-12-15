import 'package:currency_exchange/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Currency Exchange Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp()); // Change this to match your main app widget

    // Verify that the initial UI displays some text.
    expect(find.text('Welcome to Currency Exchange App!'), findsOneWidget);

    // You may need to add more tests based on your widget's behavior

    // Example: Testing if the CurrencyExchangeWidget is initially not visible
    expect(find.byType(CurrencyExchangeWidget), findsNothing);

    // Example: Trigger an action (e.g., tap on a button) to show the CurrencyExchangeWidget
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Example: Now, check if the CurrencyExchangeWidget is visible
    expect(find.byType(CurrencyExchangeWidget), findsOneWidget);

    // You can add more tests based on your widget's behavior
  });
}

class CurrencyExchangeWidget {
}
