

import 'package:access_control/domain/datasources/dollar_quote_datasource.dart';
import 'package:access_control/domain/entities/quoteDolar.dart';
import 'package:access_control/infraestructure/mappers/dollar_py_mapper.dart';
import 'package:access_control/infraestructure/models/dolarpy/dolar_py_response.dart';
import 'package:dio/dio.dart';

class DolarPyDataSources extends QuoteDolarDataSource{

  final dio = Dio(BaseOptions(
    baseUrl: 'https://dolar.melizeche.com/api/1',
  ),
  );

  @override
  Future <QuoteDolar> getDollarQuote() async {

    final response = await dio.get('https://dolar.melizeche.com/api/1.0/');
    final dolarPyResponse = DolarPyResponse.fromJson(response.data);
    final QuoteDolar quoteDollar = DolarPyMapper.dolarPyToEntity(dolarPyResponse);

    
    return quoteDollar;
  }

}