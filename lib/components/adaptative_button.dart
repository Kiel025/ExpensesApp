import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  const AdaptativeButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final Widget label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: label,
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: label,
          );
  }
}
