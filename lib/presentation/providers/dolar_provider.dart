

import 'package:access_control/domain/entities/quoteDolar.dart';
import 'package:access_control/infraestructure/repositories/dolarpy_repository_impl.dart';
import 'package:access_control/presentation/providers/dolarpy_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowGetDolarProvider = StateNotifierProvider<DolarPyNotifier , QuoteDolar>((ref) {

  final repository = ref.watch(movieRepositoryProvider);

  return DolarPyNotifier(repository: repository);
});

// State notifier -> Notifica estados

class DolarPyNotifier extends StateNotifier <QuoteDolar>{

  final DolarPyRepositorieImpl repository;
  QuoteDolar? data;

  DolarPyNotifier({required this.repository}) : super(QuoteDolar(financial: []));

  Future <void> loadDolarData() async {
    data  = await repository.getDollarQuote();
    state = data!;
  }

void sortArray(){
  // Clonamos la lista actual y la ordenamos
  List<FinancialName> sortedFinancial = List<FinancialName>.from(data!.financial)..sort((a, b) => a.compra.compareTo(b.venta));

  // Creamos una nueva instancia de QuoteDolar con la lista ordenada
  QuoteDolar newData = QuoteDolar(financial: sortedFinancial);

  // Actualizamos el estado con la nueva instancia
  state = newData;
}

}