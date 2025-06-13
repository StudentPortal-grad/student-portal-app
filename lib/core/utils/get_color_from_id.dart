import 'dart:math';
import 'package:flutter/material.dart';

Color getColorFromId(String id) {
  final hash = id.codeUnits.fold(0, (prev, e) => prev + e);
  final random = Random(hash);
  final colors = [
    Colors.redAccent,
    Colors.green,
    Colors.indigo,
    Colors.deepOrange,
    Colors.purple,
    Colors.teal,
    Colors.brown,
    Colors.blueGrey,
  ];
  return colors[random.nextInt(colors.length)];
}
