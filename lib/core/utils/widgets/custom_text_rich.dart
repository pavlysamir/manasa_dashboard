import 'package:flutter/material.dart';
import 'package:manasa_dashboard/core/utils/styles.dart';

class CustomTextRich extends StatelessWidget {
  const CustomTextRich({
    super.key,
    required this.firstText,
    required this.secondText,
  });

  final String firstText;
  final String secondText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: Text(
            secondText,
            style: Styles.textStyle14.copyWith(
              color: Colors.blue,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
        ),
        Expanded(
            child: Text(
          firstText,
          style: Styles.textStyle14.copyWith(color: Colors.black),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        )),
      ]),
    );
  }
}
