import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final TextInputType textType;

  final Function validator;

  final Widget prefix;

  final Function onTap;
  final bool isEnable;

  const CustomTextFormField({
    Key key,
    this.controller,
    this.text,
    this.textType,
    this.validator,
    this.prefix,
    this.onTap,
    this.isEnable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textType,
      validator: validator,
      onTap: onTap,
      enabled: isEnable,
      decoration: InputDecoration(
        hintText: text,
        prefixIcon: prefix,
      ),
    );
  }
}
