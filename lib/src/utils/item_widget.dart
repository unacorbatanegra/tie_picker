import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

class ItemWidget extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool selected;
  const ItemWidget({
    Key? key,
    required this.label,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      padding: zero,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: .5, color: Palette.gray5),
          ),
        ),
        constraints: const BoxConstraints(minHeight: 52),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            if (selected) const Icon(Icons.done)
          ],
        ),
      ),
    );
  }
}
