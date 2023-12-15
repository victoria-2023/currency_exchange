// TODO Implement this library.
import 'dart:convert';
import 'package:flutter/foundation.dart';


class ApiService {
  final String baseUrl = 'https://www.freecurrencyapi.com/api/v1/rates';

  Future<Map<String, dynamic>> getExchangeRate(String apiKey, String from, String to) async {
    final Uri url = Uri.parse('$baseUrl?base_currency=$from&apikey=$apiKey');
    print('API Request URL: $url');

    try {
      var http;
      final response = await http.get(url);

      if (kDebugMode) {
        print('API Response: ${response.body}');
      }

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to load exchange rate. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load exchange rate. Error: $e');
    }
  }
}
