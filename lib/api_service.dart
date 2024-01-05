import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.currencyapi.com/v3/latest?apikey=fca_live_lCd0VRhCXDdBtRSk1DTKEjPtjPjxaexcfDNAXBsb&currencies=EUR%2CUSD%2CCAD';

  String myVariable = "fca_live_lCd0VRhCXDdBtRSk1DTKEjPtjPjxaexcfDNAXBsb";

  Future<Map<String, dynamic>> getExchangeRate(String apiKey, String from, String to) async {
    final Uri url = Uri.parse('$baseUrl?base_currency=$from&to_currency=$to&apikey=$apiKey'); // Corrected URL
    print('API Request URL: $url');

    try {
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
