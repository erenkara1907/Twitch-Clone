import 'package:flutter/material.dart';
import 'package:twitch_app/utils/color.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onTap;
  const AppTextField({Key? key, required this.controller, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onTap,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: buttonColor, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryBackgroundColor, width: 2.0),
        ),
      ),
    );
  }
}
