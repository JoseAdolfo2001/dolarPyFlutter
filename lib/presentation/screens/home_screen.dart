import 'package:access_control/config/router/app_router.dart';
import 'package:access_control/presentation/providers/dolar_provider.dart';
import 'package:access_control/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
  
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    _controller.addListener(_formatText);
   
    ref.read(nowGetDolarProvider.notifier).loadDolarData();    
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

void _formatText() {
  _controller.removeListener(_formatText); // Elimina el listener temporalmente

  String text = _controller.text.replaceAll(RegExp('[^0-9]'), '');
  if (text.isEmpty) {
    _controller.text = '';
  } else {
    double number = double.parse(text) / 100;

    if (number > 0) {
      String newText = NumberFormat.currency(locale: 'en_US', symbol: '\$  ', decimalDigits: 2).format(number);
      _controller.text = newText;
    } else {
      _controller.text = '';
    }
  }

  if (_controller.text.isNotEmpty) {
    int cursorPosition = _controller.text.length;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: cursorPosition));
  }

  _controller.addListener(_formatText); 
}

void _showDialog(){
  showDialog(context: context, 
  builder: (context){
      return  AlertDialog(
        title: const Text("Cotizaciones dolar"),
        content: Container(
          width: double.maxFinite,
          height: 1000,
          child: const Text("hola"),
        ),
      );
    });
}

  @override
  Widget build(BuildContext context) {

    final nowDolarQuote = ref.watch(nowGetDolarProvider);

    

    return Column(
      children: [
        
        TextInputCustom(controller: _controller,),

        ElevatedButton(
          onPressed: (){
            appRouter.push('/quote' , extra: nowDolarQuote);
        }, child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text("cotizar" , 
             style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),),
        )),
        
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

  final TextEditingController controller;

  const TextInputCustom({
    super.key, required this.controller,
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
        style: const TextStyle(fontSize: 24),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        controller: controller,
      ),
    );
  }
}

