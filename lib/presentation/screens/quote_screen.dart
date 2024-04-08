import 'package:access_control/domain/entities/quoteDolar.dart';
import 'package:access_control/presentation/providers/dolar_provider.dart';
import 'package:access_control/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class QuoteScreen extends ConsumerWidget {
  QuoteDolar dolarQuote;

  static const name = "Quote-Screen";

  QuoteScreen({super.key, required this.dolarQuote});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    
    final segmentedControllIndex = ref.watch(segmentedControllerProvider);
    final dolarValue = ref.watch(miValorProvider);

    return Scaffold(
        appBar: AppBar(title: const Text("Cotizaciones")),
        body: Column(children: [
          const SizedBox(
            height: 24,
          ),
          CupertinoSegmentedControl<int>(
            children: const {
              0: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16), // Ajusta a tus necesidades
                child: Text("Compra" , style: TextStyle(color: Colors.black),),
              ),
              1: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16), // Ajusta a tus necesidades
                child: Text("Venta" , style: TextStyle(color: Colors.black),),
              ),
            },
              onValueChanged: (int newValue) {
                // Actualiza el valor del provider del segmented control
                ref.read(segmentedControllerProvider.state).state = newValue;

                // Llama a sortArrayByCompraOrVenta según la selección
                // true para compra (index 0), false para venta (index 1)
                dolarQuote = ref.read(nowGetDolarProvider.notifier)
                    .sortArrayByCompraOrVenta(newValue == 0);
              },
            groupValue: segmentedControllIndex,
            pressedColor: Colors.green.withOpacity(0.1),
            selectedColor: const Color(0xFFE1F0DA),
            unselectedColor: Colors.transparent,
            padding: const EdgeInsets.all(5),
          ),
          const SizedBox(
            height: 6,
          ),

          ValueToQuoteWidget(dolarValue: dolarValue.toString(),),

          const SizedBox(height: 8,),

          Expanded(
              child: _ListQuote(
            dolarQuote: dolarQuote,
            index:segmentedControllIndex,
            valueDolar: dolarValue,
          ))
        ]));
  }

  String calculateValue(double value , double quoteDolar){
    var valueInGuaranies = value * quoteDolar;
    return valueInGuaranies.toString();
  }
}

class ValueToQuoteWidget extends StatelessWidget {
  final String dolarValue;
  const ValueToQuoteWidget({
    super.key, required this.dolarValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text(
        'Monto a cotizar en guaraníes',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 5),
      Text(
        '$dolarValue USD',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.green[900],
        ),
      ),
    ],
  ),
);

  }
}

class _ListQuote extends StatelessWidget {
  final QuoteDolar dolarQuote;
  final int index;
  final double valueDolar;
  const _ListQuote({
    super.key,
    required this.dolarQuote,
    required this.index,
    required this.valueDolar
  });

  

  @override
  Widget build(BuildContext context) {
    List<FinancialName> filterList = filterEmptyQuote(dolarQuote.financial);
    return ListView.builder(
        itemBuilder: (context, index) {
          bool isBestQuote = false;
          bool isBadQuote = false;
          if(index == 0){
            isBestQuote = true;
          }else if(filterList[index].entidad == filterList.last.entidad) {
              isBadQuote = true;
          }
          return Container(
              margin: const EdgeInsetsDirectional.symmetric(
              horizontal: 16, vertical: 12),
              child: ItemQouote(financialName: filterList[index] , typeOperation: this.index, valueDolar: valueDolar, isBestQuote: isBestQuote, isWorstQuote: isBadQuote,));
        },
        itemCount: filterList.length);
  }

  List<FinancialName> filterEmptyQuote(List<FinancialName> financialName){
    var finalcialFilter = financialName.where((quote) => quote.compra != "0.0").toList();
    return finalcialFilter;
  }
}
