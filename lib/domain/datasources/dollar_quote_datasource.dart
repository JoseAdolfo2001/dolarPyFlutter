
import 'package:access_control/domain/entities/quoteDolar.dart';

abstract class QuoteDolarDataSource{

    Future <QuoteDolar> getDollarQuote();
    
}