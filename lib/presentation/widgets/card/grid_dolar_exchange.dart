

import 'package:access_control/domain/entities/quoteDolar.dart';
import 'package:access_control/presentation/widgets/widgetstyles/text_format_style.dart';
import 'package:flutter/material.dart';

class CardDolarExchangev2 extends StatelessWidget {
  final FinancialName finalcialName;
  const CardDolarExchangev2({super.key, required this.finalcialName});


  @override
  Widget build(BuildContext context) {
    return  Card(
      color: const Color(0xFFCFE8FB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child:  Padding(
          padding:  const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
              const SizedBox(height: 15.0,),
              const Icon(Icons.food_bank_outlined ,color: Color(0xFF118EEA),size: 32.0),
              const SizedBox(height: 8.0,),
              TextFormat(text:formatFinanciedName(finalcialName.entidad) , size: 16 , fontWeight: FontWeight.bold,),
              const SizedBox(height: 4.0,),             
              const TextFormat(text: "Compra - Venta" , size: 14, fontWeight: FontWeight.normal,),
              const SizedBox(height: 4.0,),
              TextFormat(fontWeight: FontWeight.normal , size: 14, text: "Gs ${removeDecimalFromString(finalcialName.compra)} - Gs ${removeDecimalFromString(finalcialName.venta)}")
            ],
          ),
        ),

    );
  }

  String formatFinanciedName(String name){
  
    switch(name){
      case "bcp" : return "BCP";
      case "bonanza" : return "Bonanza Cambios";
      case "cambiosalberdi" : return "Cambios Alberdi";
      case "cambioschaco" : return "Cambios Chaco";
      case "eurocambios" : return "Euro Cambios";
      case "gnbfusion" : return "GNB FUSION";
      case "lamoneda" : return "Moneda Cambios";
      case "maxicambios" : return "Maxi Cambios";
      case "set" : return "SET";
      case "vision" : return "Vision Banco";
      case "mundialcambios" : return "Mundial Cambios";
      case "mydcambios" : return "MyD Cambios";
      default : "";
    }
    return "";

  }

  String removeDecimalFromString(String numberStr) {
  // Divide el string en dos partes basado en el punto decimal.
  List<String> parts = numberStr.split('.');
  // Retorna solo la parte entera.
  return parts[0];
}

}