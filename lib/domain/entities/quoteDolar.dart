

class QuoteDolar{

  final List<FinancialName> financial;

  QuoteDolar({
    required this.financial
  });

}

class FinancialName{
  final String entidad;
  final String compra;
  final String venta;

  FinancialName({
    required this.entidad,
    required this.compra,
    required this.venta
  });
}




