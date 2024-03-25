

import 'package:access_control/domain/datasources/dollar_quote_datasource.dart';
import 'package:access_control/domain/entities/quoteDolar.dart';
import 'package:access_control/domain/repositories/quote_dolar_repository.dart';

class DolarPyRepositorieImpl extends QuoteDolarRepository{

  final QuoteDolarDataSource dataSource;

  DolarPyRepositorieImpl({required this.dataSource});

  @override
  Future <QuoteDolar> getDollarQuote() {
    return dataSource.getDollarQuote();
  }

}