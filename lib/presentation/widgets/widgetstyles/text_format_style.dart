

import 'package:flutter/material.dart';

class  TextFormat extends StatelessWidget {

  final String text;
  final FontWeight fontWeight;
  final double size;


  const TextFormat({
    super.key, 
    required this.text, required this.fontWeight, required this.size,
    });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:  TextStyle(fontSize: size , fontWeight: fontWeight , color: const Color(0xFF118EEA)),
    );
  }
}