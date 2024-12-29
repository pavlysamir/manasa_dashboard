import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:manasa_dashboard/core/Assets/assets.dart';

class CustomLottieAnimation extends StatelessWidget {
  const CustomLottieAnimation(
      {super.key,
      this.image = AssetsData.loadingLottie,
      this.hight = 100,
      this.width = 100});
  final String image;
  final double hight;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        image, // Path to your Lottie JSON file in assets
        width: width, // You can adjust the size based on your need
        height: hight,
        fit: BoxFit.fill, // Adjust the BoxFit as needed (cover, contain, etc.)
      ),
    );
  }
}
