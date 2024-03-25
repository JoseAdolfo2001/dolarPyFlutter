

import 'package:access_control/infraestructure/datasources/dolarpy_datasource.dart';
import 'package:access_control/infraestructure/repositories/dolarpy_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref) {
  return DolarPyRepositorieImpl(dataSource: DolarPyDataSources());
},);