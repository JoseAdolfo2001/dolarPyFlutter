

import 'package:access_control/domain/entities/quoteDolar.dart';
import 'package:access_control/presentation/widgets/widgetstyles/text_format_style.dart';
import 'package:flutter/material.dart';

class ItemQouote extends StatelessWidget {
  final FinancialName financialName;
  final int typeOperation;
  final double valueDolar;
  const ItemQouote({
    super.key, 
    required this.financialName,
    required this.typeOperation,
    required this.valueDolar
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
              TextFormat(text: "Compra: Gs. ${formatNumber(financialName.compra)}" , fontWeight : FontWeight.normal  , size:14),
              TextFormat(text: "Venta: Gs. ${formatNumber(financialName.venta)}" , fontWeight : FontWeight.normal  , size:14),
            ],
            
          ),
          const SizedBox(height: 8,),

          TextFormat(text: typeSetText(typeOperation) , fontWeight : FontWeight.bold  , size:14),
          TextFormat(text: "Gs ${valueInGuaranies(valueDolar, financialName, typeOperation)}" , fontWeight: FontWeight.bold , size : 18,),

          const SizedBox(height: 12,),
        ],
      ),
    );
  }

  String typeSetText(int index){
      String text = "";
      if(index == 0 ){
        text = "Cotizacion a la compra";
      }else {
        text = "Cotizacion a la venta";
      }
      return text;
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

 String valueInGuaranies(double dolarValue , FinancialName finalcial , int indexControll){
    double quoteDolarValue = 0.0;
    if(indexControll == 0){
      quoteDolarValue = double.tryParse(finalcial.compra) ?? 0.0;
    }else{
      quoteDolarValue = double.tryParse(finalcial.venta) ?? 0.0;
    }
    var valueGuaranies = dolarValue * quoteDolarValue;
    return formatNumber(valueGuaranies.toString());
 } 

String formatNumber(String numberStr) {
  // Divide el string en dos partes basado en el punto decimal.
  List<String> parts = numberStr.split('.');
  // Obtiene la parte entera.
  String integerPart = parts[0];

  // Invierte la parte entera para facilitar la inserción de puntos.
  String reversedIntegerPart = integerPart.split('').reversed.join('');
  // Inserta un punto cada tres dígitos.
  String formattedReversedIntegerPart = RegExp(r'.{1,3}').allMatches(reversedIntegerPart).map((match) => match.group(0)).join('.');
  // Vuelve a invertir la cadena para obtener el formato correcto.
  String formattedIntegerPart = formattedReversedIntegerPart.split('').reversed.join('');

  // Retorna solo la parte entera formateada.
  return formattedIntegerPart;
}
}