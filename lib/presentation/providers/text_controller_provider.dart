

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textEditingControllerProvider =  StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});