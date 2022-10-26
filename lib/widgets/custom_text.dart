import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String txtName;
  final EdgeInsets margin;
  final TextStyle style;
  final TextAlign align;

  const CustomText({
    Key? key,
    required this.txtName,
    required this.margin,
    required this.style,
    required this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = Text(
      txtName,
      style: style,
      textAlign: align,
    );
    final padding = Padding(
      padding: margin,
      child: text,
    );
    return padding;
  }
}
