import 'package:flutter/material.dart';
import 'package:manasa_dashboard/core/extensions/mediaQuery_extensions.dart';
import 'package:manasa_dashboard/core/utils/widgets/custom_fading_widget.dart';

class CustomListViewLoadingIndicator extends StatelessWidget {
  const CustomListViewLoadingIndicator({super.key, required this.widget});
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return CustomFadingWidget(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: context.widthMediaQuery * 0.3,
            height: context.hightMediaQuery * 0.05,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 15,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: widget,
                );
              }),
        ),
      ],
    ));
  }
}
