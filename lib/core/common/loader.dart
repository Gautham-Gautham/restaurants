import 'package:flutter/material.dart';
import 'package:the_grandmerche/core/constants/colors/palletes.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: Pallets.orange,
    ));
  }
}
