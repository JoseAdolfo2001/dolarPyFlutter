

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

  DolarPyNotifier({required this.repository}) : super(QuoteDolar(financial: []));

  Future <void> loadDolarData() async {
    final data  = await repository.getDollarQuote();
    state = data;
  }

}