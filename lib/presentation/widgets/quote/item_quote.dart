

import 'package:access_control/domain/entities/quoteDolar.dart';
import 'package:access_control/presentation/widgets/widgetstyles/text_format_style.dart';
import 'package:flutter/material.dart';

class ItemQouote extends StatelessWidget {
  final FinancialName financialName;
  final int typeOperation;
  const ItemQouote({
    super.key, 
    required this.financialName,
    required this.typeOperation
    });

  @override
  Widget build(BuildContext context) {
    return  Card(
      color:const Color(0xFFD8F8D4),
      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10), // Bordes redondeados
    side: BorderSide(
          color: Colors.black.withOpacity(0.2), // Color del borde
          width: 1,)// Grosor del borde
    ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8,),
          Text(formatFinanciedName(financialName.entidad)),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormat(text: "Compra: Gs. ${removeDecimalFromString(financialName.compra)}" , fontWeight : FontWeight.normal  , size:12),
              TextFormat(text: "Venta: Gs. ${removeDecimalFromString(financialName.venta)}" , fontWeight : FontWeight.normal  , size:12),
            ],
            
          ),
          const SizedBox(height: 8,),

          const TextFormat(text: "Cotizacion a la compra" , fontWeight : FontWeight.bold  , size:14),
          TextFormat(text: "Gs. ${typeSetText(typeOperation , financialName)}" , fontWeight: FontWeight.bold , size : 18,),

          const SizedBox(height: 12,),
        ],
      ),
    );
  }

  String typeSetText(int index , FinancialName finalcial){
      String text = "";
      if(index == 0 ){
        text = finalcial.compra;
      }else {
        text = finalcial.venta;
      }
      return removeDecimalFromString(text);
  }

    String formatFinanciedName(String name){
  
    switch(name){
      case "bcp" : return "Banco Central de Paraguay";
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