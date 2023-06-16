import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  final Color iconColor;
  final IconData? iconData;
  final bool outline;
  final bool icon;
  final bool alt;
  final bool dialog;
  final double minSize;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.label,
    this.minSize = 48,
    this.iconData,
    this.iconColor = Colors.white,
  })  : outline = false,
        icon = false,
        alt = false,
        dialog = false,
        super(key: key);

  const CustomButton.outline({
    Key? key,
    required this.onTap,
    required this.label,
    this.minSize = 52,
    this.iconData,
    this.iconColor = Colors.white,
  })  : outline = true,
        icon = false,
        alt = false,
        dialog = false,
        super(key: key);

  const CustomButton.alt({
    Key? key,
    required this.onTap,
    required this.label,
    this.minSize = 52,
    this.iconData,
    this.iconColor = Colors.white,
  })  : outline = false,
        icon = false,
        alt = true,
        dialog = false,
        super(key: key);

  const CustomButton.icon({
    Key? key,
    required this.onTap,
    required this.label,
    required this.iconData,
    this.minSize = 52,
    this.iconColor = Colors.white,
  })  : outline = false,
        icon = true,
        alt = false,
        dialog = false,
        super(key: key);

  const CustomButton.dialog({
    Key? key,
    required this.onTap,
    required this.label,
    this.iconData,
    this.minSize = 52,
    this.iconColor = Colors.white,
  })  : outline = false,
        icon = false,
        alt = false,
        dialog = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    if (dialog) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: color,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    }
    if (alt) {
      return GestureDetector(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Palette.culture,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                  size: 16.0,
                  color: color,
                ),
              if (iconData != null) const SizedBox(width: 6.0),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  // fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        onTap: onTap,
      );
    }
    if (icon) {
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: color,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                  size: 16.0,
                  color: iconColor,
                ),
              if (iconData != null) const SizedBox(width: 6.0),
              Text(
                label,
                style: const TextStyle(
                  color: Palette.gray1,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        onTap: onTap,
      );
    }
    if (outline) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          height: minSize,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            border: Border.all(
              width: 1,
              color: Palette.gray2,
            ),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: Text(
            label,
            style: const TextStyle(
              color: Palette.gray2,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        onPressed: onTap,
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 44.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 32.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (iconData != null)
              Icon(
                iconData,
                size: 18.0,
                color: iconColor,
              ),
            if (iconData != null) const SizedBox(width: 12.0),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
