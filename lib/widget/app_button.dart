import 'package:flutter/material.dart';
import 'package:twitch_app/utils/color.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const AppButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        minimumSize: const Size(double.infinity, 40.0),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
