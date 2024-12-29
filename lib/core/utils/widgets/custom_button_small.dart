import 'package:flutter/material.dart';
import 'package:manasa_dashboard/core/constants.dart';
import 'package:manasa_dashboard/core/extensions/mediaQuery_extensions.dart';
import 'package:manasa_dashboard/core/utils/styles.dart';

class CustomButtonSmall extends StatelessWidget {
  const CustomButtonSmall(
      {super.key,
      required this.function,
      required this.text,
      this.color = kPrimaryKey,
      this.textColortcolor = Colors.white,
      this.width = 78,
      required this.borderColor});
  final Function() function;
  final String text;
  final Color color;
  final Color textColortcolor;
  final double width;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: function,
        child: Container(
          height: context.hightMediaQuery * 0.06,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: Styles.textStyle14White.copyWith(color: textColortcolor),
            ),
          ),
        ));
  }
}
