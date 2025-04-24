import 'package:flutter/material.dart';

class XoBtn extends StatelessWidget {
  final String label;
  final VoidCallback onClick;
  final int index;

  const XoBtn(
      {super.key,
      required this.label,
      required this.onClick,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
