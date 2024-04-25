class CryptoCurrency {
  final String symbol;
  final double price;
  // Agrega más propiedades si necesitas más datos

  CryptoCurrency(this.symbol, this.price);

  // Añade un método factory para crear una instancia a partir de un JSON
  factory CryptoCurrency.fromJson(Map<String, dynamic> json) {
    return CryptoCurrency(
      json['symbol'],
      double.parse(json['price']),
    );
  }
}
