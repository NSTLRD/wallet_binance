import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/crypto_currency.dart';

class BinanceService {
  final String baseUrl = 'https://api.binance.com';

  Future<dynamic> getMarketData(String symbol) async {
    var response = await http.get(Uri.parse('$baseUrl/api/v3/ticker/price?symbol=$symbol'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load market data: ${response.body}');
    }
  }

  Future<List<CryptoCurrency>> getAllMarketData() async {
    var response = await http.get(Uri.parse('$baseUrl/api/v3/ticker/price'));
    if (response.statusCode == 200) {
      List<dynamic> allData = json.decode(response.body);
      List<CryptoCurrency> currencies = allData.map((json) => CryptoCurrency.fromJson(json)).toList();
      return currencies;
    } else {
      throw Exception('Failed to load market data');
    }
  }

}
