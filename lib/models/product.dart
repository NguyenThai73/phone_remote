import 'package:flutter/material.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.sold,
    required this.colors,
    required this.storage,
    required this.screen,
    required this.camera,
    required this.battery,
    required this.chip,
    required this.description,
    required this.accent,
    required this.badge,
  });
  final String id,
      name,
      brand,
      screen,
      camera,
      battery,
      chip,
      description,
      badge;
  final int price, oldPrice, sold;
  final double rating;
  final List<Color> colors;
  final List<String> storage;
  final Color accent;
}

String money(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (var index = 0; index < digits.length; index++) {
    if (index > 0 && (digits.length - index) % 3 == 0) buffer.write('.');
    buffer.write(digits[index]);
  }
  return '${buffer.toString()}₫';
}
