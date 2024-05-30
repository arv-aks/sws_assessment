import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: SizedBox(
        width: 30, height: 30,
        child: CircularProgressIndicator(strokeWidth: 1.5)));
  }
}
