import 'package:access_control/presentation/providers/dolar_provider.dart';
import 'package:access_control/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const   name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: const Text('DolarPy'),
      ),
      body:  const _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  String _currentSortBy = 'venta';
  @override
  void initState() {
    super.initState();

    ref.read(nowGetDolarProvider.notifier).loadDolarData();    
  }

  @override
  Widget build(BuildContext context) {

    final nowDolarQuote = ref.watch(nowGetDolarProvider);

    return Column(
      children: [
        
        const TextInputCustom(),

        DropdownButton<String>(
          value: _currentSortBy,
          underline: Container(
            height: 2,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          icon: Icon(Icons.arrow_downward, color: const Color.fromARGB(255, 0, 0, 0)),
          onChanged: (String? newValue) {
            setState(() {
              _currentSortBy = newValue!;
              ref.read(nowGetDolarProvider.notifier).sortDataBy(_currentSortBy);
            });
          },
          items: <String>['venta', 'compra']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            );
          }).toList(),
        ),
        Expanded(
            child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing:10,
              childAspectRatio: 33/34,
            ), 
            itemCount: nowDolarQuote.financial.length,
            itemBuilder: (context , index){
            return  CardDolarExchangev2(finalcialName: nowDolarQuote.financial[index],);
          }
          ),
        ),
      ]
    );
  }
}

class TextInputCustom extends StatelessWidget {
  const TextInputCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
            borderSide: const BorderSide(width: 2.0),
            borderRadius: BorderRadius.circular(10.0)
          );
    var inputDecoration = InputDecoration(
          hintText: "ingrese monto",
          labelText: "Monto",
          suffixIcon: const Icon(Icons.currency_exchange),
          border: outlineInputBorder,
          labelStyle: const TextStyle(fontWeight: FontWeight.w500 , fontSize:24.0)
        );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child:  TextField(
        decoration: inputDecoration,
        autofocus: false,
      ),
    );
  }
}