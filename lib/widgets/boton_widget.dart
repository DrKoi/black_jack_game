import 'package:flutter/material.dart';

class botonWidget extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  botonWidget({required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.amber,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
