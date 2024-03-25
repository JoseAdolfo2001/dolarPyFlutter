import 'package:access_control/presentation/providers/dolar_provider.dart';
import 'package:access_control/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const   name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body:  _HomeView(),
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
         SizedBox(
          height: 270,
           child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                height: 170,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(  
                    bottomLeft:  Radius.circular(32) , bottomRight: Radius.circular(30)),
                  color :Color(0xFFCFE8FB),
                ),
              ),
              Positioned(
                top: 120,
                child: Container(
                  height: 140,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF118EEA),
                  ),
              ))
              ]
            ),
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