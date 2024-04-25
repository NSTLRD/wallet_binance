import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../services/binance_service.dart';
import '../models/crypto_currency.dart';
import '../main.dart'; // Asegúrate de importar el archivo donde tienes tus colores definidos

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<CryptoCurrency> _currencies = [];
  final Map<String, List<FlSpot>> _chartData = {}; // Datos de gráficos ficticios por ahora

  @override
  void initState() {
    super.initState();
    _fetchMarketData();
  }

  void _fetchMarketData() async {
    var currencies = await Provider.of<BinanceService>(context, listen: false).getAllMarketData();
    setState(() {
      _currencies = currencies;
      // Inicializa datos de gráfico con datos ficticios para cada moneda
      for (var currency in currencies) {
        _chartData[currency.symbol] = [FlSpot(0, currency.price)];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criptomonedas"),
        backgroundColor: binanceBlue, // Color del AppBar modificado para usar el azul de Binance
      ),
      body: ListView.builder(
        itemCount: _currencies.length,
        itemBuilder: (context, index) {
          var currency = _currencies[index];
          return Card(
            color: binanceGrey, // Fondo de la tarjeta con el gris de Binance
            elevation: 2,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                currency.symbol,
                style: TextStyle(color: binanceYellow), // Texto con el amarillo de Binance
              ),
              subtitle: Text(
                'Último precio: ${currency.price}',
                style: TextStyle(color: Colors.white), // Texto con color blanco para el subtítulo
              ),
              trailing: SizedBox(
                width: 100,
                height: 50,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _chartData[currency.symbol] ?? [],
                        isCurved: true,
                        colors: [binanceYellow], // Gráfico con el amarillo de Binance
                        barWidth: 2,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
