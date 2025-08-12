import 'package:flutter/material.dart';
class RoundCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const RoundCheckbox({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged?.call(!value);
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          color: value ? Colors.blue : Colors.transparent,
        ),
        child: value
            ? Icon(
          Icons.check,
          size: 16,
          color: Colors.white,
        )
            : null,
      ),
    );
  }
}