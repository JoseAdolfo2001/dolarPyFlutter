import 'package:access_control/domain/entities/quoteDolar.dart';
import 'package:access_control/presentation/providers/dolar_provider.dart';
import 'package:access_control/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuoteScreen extends ConsumerWidget {
  QuoteDolar dolarQuote;

  static const name = "Quote-Screen";

  QuoteScreen({super.key, required this.dolarQuote});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    
    final segmentedControllIndex = ref.watch(segmentedControllerProvider);

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
                child: Text("Compra"),
              ),
              1: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16), // Ajusta a tus necesidades
                child: Text("Venta"),
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
            pressedColor: Colors.green.withOpacity(0.5),
            unselectedColor: Colors.transparent,
            padding: const EdgeInsets.all(5),
          ),
          const SizedBox(
            height: 6,
          ),
          Expanded(
              child: _ListQuote(
            dolarQuote: dolarQuote,
            index:segmentedControllIndex
          ))
        ]));
  }
}

class _ListQuote extends StatelessWidget {
  final QuoteDolar dolarQuote;
  final int index;
  const _ListQuote({
    super.key,
    required this.dolarQuote,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsetsDirectional.symmetric(
                  horizontal: 16, vertical: 12),
              child: ItemQouote(financialName: dolarQuote.financial[index] , typeOperation: this.index,));
        },
        itemCount: dolarQuote.financial.length);
  }
}
