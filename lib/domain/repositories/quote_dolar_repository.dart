
import 'package:access_control/domain/entities/quoteDolar.dart';

abstract class QuoteDolarRepository{

    Future <QuoteDolar> getDollarQuote();
    
}