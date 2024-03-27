

class QuoteDolar {
  final List<FinancialName> financial;

  QuoteDolar({required this.financial});

  QuoteDolar copyWith({List<FinancialName>? financial}) {
    return QuoteDolar(
      financial: financial ?? this.financial,
    );
  }
}

class FinancialName {
  final String entidad;
  final String compra;
  final String venta;

  FinancialName({
    required this.entidad,
    required this.compra,
    required this.venta,
  });

  FinancialName copyWith({
    String? entidad,
    String? compra,
    String? venta,
  }) {
    return FinancialName(
      entidad: entidad ?? this.entidad,
      compra: compra ?? this.compra,
      venta: venta ?? this.venta,
    );
  }
}





