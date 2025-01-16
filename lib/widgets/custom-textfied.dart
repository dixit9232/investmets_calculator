import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../global_variable.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final Widget? suffixIcon;
  final String? labelText;
  final TextInputType? keyboardType;

  const CustomTextField({super.key, required this.textEditingController, this.suffixIcon, this.labelText, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.9,
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType ?? TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'^-?\d*\.?\d*'),
          )
        ],
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: suffixIcon,
            )),
      ),
    );
  }
}
