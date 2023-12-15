// main.dart
import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiService apiService = ApiService();
  String fromCurrency = 'EUR';
  String toCurrency = 'USD';
  double exchangeRate = 0.0;
  TextEditingController amountController = TextEditingController();
  double convertedAmount = 0.0;

  void _refresh() async {
    try {
      final data = await apiService.getExchangeRate(fromCurrency, toCurrency);
      setState(() {
        exchangeRate = data['data'][toCurrency];
        // Call the _convert method with the current amount in the text field
        _convert();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _convert() {
    // Convert the amount to double, default to 0.0 if parsing fails
    double amount = double.tryParse(amountController.text) ?? 0.0;
    // Calculate the converted amount
    setState(() {
      convertedAmount = amount * exchangeRate;
    });
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refresh,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: fromCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        fromCurrency = newValue!;
                        _refresh();
                      });
                    },
                    items: <String>['EUR', 'USD', 'GBP', 'JPY', 'CAD']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Icon(Icons.arrow_forward),
                Flexible(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: toCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        toCurrency = newValue!;
                        _refresh();
                      });
                    },
                    items: <String>['EUR', 'USD', 'GBP', 'JPY', 'CAD']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Amount'),
              onChanged: (value) {
                // Call the _convert method whenever the amount changes
                _convert();
              },
            ),
            SizedBox(height: 20.0),
            Text(
              '${amountController.text} $fromCurrency = ${convertedAmount.toStringAsFixed(2)} $toCurrency',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }
}
