

import 'package:access_control/domain/entities/quoteDolar.dart';
import 'package:access_control/infraestructure/repositories/dolarpy_repository_impl.dart';
import 'package:access_control/presentation/providers/dolarpy_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// notifica cuando se procesa todo la llamada al servicio
final nowGetDolarProvider = StateNotifierProvider<DolarPyNotifier , QuoteDolar>((ref) {

  final repository = ref.watch(movieRepositoryProvider);

  return DolarPyNotifier(repository: repository);
});

// notifica cuando se ordena la lista

final segmentedControllerProvider =  StateProvider((ref) => 0);

final miValorProvider = StateProvider<double>((ref) => 0);


// State notifier -> Notifica estados

class DolarPyNotifier extends StateNotifier <QuoteDolar>{

  final DolarPyRepositorieImpl repository;
  QuoteDolar? data;

  DolarPyNotifier({required this.repository}) : super(QuoteDolar(financial: []));

  Future <void> loadDolarData() async {
    data  = await repository.getDollarQuote();
    state = sortArrayByCompraOrVenta(true);
  }

QuoteDolar sortArrayByCompraOrVenta(bool sortByCompra) {
  // Determinar el criterio de ordenamiento en base al valor de sortByCompra
  List<FinancialName> sortedFinancial = List<FinancialName>.from(data!.financial)
    ..sort((a, b) => sortByCompra ? a.compra.compareTo(b.compra) : a.venta.compareTo(b.venta));

  // Creamos una nueva instancia de QuoteDolar con la lista ordenada
  return QuoteDolar(financial: sortedFinancial);
}

}