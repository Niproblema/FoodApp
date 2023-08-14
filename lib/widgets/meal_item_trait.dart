import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  final IconData _icon;
  final String _label;

  const MealItemTrait(this._icon, this._label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(_icon, size: 17, color: Colors.white),
        const SizedBox(width: 6),
        Text(_label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
