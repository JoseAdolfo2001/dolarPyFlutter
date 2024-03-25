
class DolarPyResponse{
  final Map<String , CurrencyExchange> dolarPyResponse;
  final DateTime updated;


  DolarPyResponse({
    required this.dolarPyResponse,
    required this.updated
  });

  factory DolarPyResponse.fromJson(Map<String, dynamic> json) {
    final dolarPyMap = json['dolarpy'] as Map<String, dynamic>;
    Map<String, CurrencyExchange> dolarPy = {};
    dolarPyMap.forEach((key, value) {
      dolarPy[key] = CurrencyExchange.fromJson(value as Map<String, dynamic>);
    });

    return DolarPyResponse(
      dolarPyResponse: dolarPy,
      updated: DateTime.parse(json['updated']),
    );
  }
}


class CurrencyExchange{
  final double compra;
  final double? venta;
  final double? referencialDiario;

  CurrencyExchange({
    required this.compra,
    this.venta,
    this.referencialDiario
  });

  factory CurrencyExchange.fromJson(Map<String , dynamic> json){

    return CurrencyExchange(

      compra: json['compra'].toDouble(),
      venta:json.containsKey('venta') ? json['venta'].toDouble() : null,
      referencialDiario: json.containsKey('referencial_diario') ? json['referencial_diario'].toDouble() : null

    );
  }
}