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
          return Container(
              margin: const EdgeInsetsDirectional.symmetric(
                  horizontal: 16, vertical: 12),
              child: ItemQouote(financialName: filterList[index] , typeOperation: this.index, valueDolar: valueDolar,));
        },
        itemCount: filterList.length);
  }

  List<FinancialName> filterEmptyQuote(List<FinancialName> financialName){
    var finalcialFilter = financialName.where((quote) => quote.compra != "0.0").toList();
    return finalcialFilter;
  }
}
