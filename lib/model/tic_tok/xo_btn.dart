import 'package:flutter/material.dart';

// ignore: must_be_immutable
class XoBtn extends StatelessWidget {
  String label;
  int index;
  XoBtn(
      {super.key,
      required this.label,
      required this.onClick,
      required this.index});
  Function onClick;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(1),
      child: ElevatedButton(
        onPressed: () {
          onClick(index);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.pink,
                  width: 2,
                  strokeAlign: 4,
                ),
                borderRadius: BorderRadius.circular(24))),
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    ));
  }
}
