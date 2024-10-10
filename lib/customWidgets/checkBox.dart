import 'package:flutter/material.dart';

// Custom Checkbox Widget with Size Parameter
class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final double size;

  const CustomCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
    this.size = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Checkbox(
        checkColor: Colors.purple,
        fillColor: WidgetStateProperty.resolveWith(_getColor),
        value: isChecked,
        onChanged: onChanged,
      ),
    );
  }

  Color _getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
    };
    return states.any(interactiveStates.contains) ? Colors.blue : Colors.white;
  }
}

// Main Checkbox Widget
class MyCheckboxWidget extends StatelessWidget {
  final double size;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const MyCheckboxWidget({
    super.key,
    required this.size,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCheckbox(
      isChecked: value,
      onChanged: onChanged,
      size: size,
    );
  }
}