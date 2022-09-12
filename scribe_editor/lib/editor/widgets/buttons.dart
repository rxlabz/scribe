import 'package:flutter/material.dart';

class LabelToggleButtons extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final String label;

  const LabelToggleButtons({
    required this.selected,
    required this.icon,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconView = Icon(icon, color: theme.primaryColor);

    return selected
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                iconView,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(label),
                )
              ],
            ),
          )
        : Tooltip(message: label, child: iconView);
  }
}
