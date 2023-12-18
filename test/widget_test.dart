import 'package:currency_exchange/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Currency Exchange Widget Test', (WidgetTester tester) async {

    await tester.pumpWidget(MyApp());


    expect(find.text('Welcome to Currency Exchange App!'), findsOneWidget);


    expect(find.byType(CurrencyExchangeWidget), findsNothing);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.byType(CurrencyExchangeWidget), findsOneWidget);

  });
}

class CurrencyExchangeWidget {
}
