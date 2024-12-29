import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manasa_dashboard/core/constants.dart';
import 'package:manasa_dashboard/core/extensions/mediaQuery_extensions.dart';

class CustomButtonLarge extends StatelessWidget {
  const CustomButtonLarge(
      {super.key,
      required this.text,
      // required this.color,
      required this.textColor,
      required this.function,
      this.icon});
  final String text;
  // final Color color;
  final Color textColor;
  final Function() function;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: context.hightMediaQuery * 0.07,
        width: context.widthMediaQuery * 0.4,
        decoration: BoxDecoration(
          //color: color,
          gradient: const LinearGradient(colors: buttonGradient),
          border: Border.all(color: kPrimaryKey),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
            child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.labelLarge,
            children: [
              TextSpan(
                  text: text,
                  style: GoogleFonts.almarai(
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  )
                  // const TextStyle(
                  //   fontFamily: ,
                  //   overflow: TextOverflow.ellipsis)

                  ),
              WidgetSpan(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: icon,
              )),
            ],
          ),
        )),
      ),
    );
  }
}
