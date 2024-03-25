

import 'package:access_control/domain/entities/quoteDolar.dart';
import 'package:access_control/infraestructure/models/dolarpy/dolar_py_response.dart';

class DolarPyMapper {
  static QuoteDolar dolarPyToEntity(DolarPyResponse dolarResponse) {
    // Convertimos el mapa a una lista de FinancialName
    List<FinancialName> financials = dolarResponse.dolarPyResponse.entries.map((entry) {
      final entidad = entry.key;
      final compra = entry.value.compra.toString();
      final venta = entry.value.venta.toString();
      // Aquí asumimos que el 'key' podría ser utilizado como identificador de la entidad financiera si es necesario
      return FinancialName(
        compra: compra,
        venta: venta ,
        entidad: entidad
      );
    }).toList();

    return QuoteDolar(financial: financials);
  }
}
