import 'package:empire_app_ui/components/components.dart';
import 'package:empire_app_ui/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final String? backgroundImage;
  final VoidCallback onPress;
  final double? width;

  const CommonButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.backgroundImage,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            backgroundImage ?? AppImages.startButtonBackground,
            width: width ?? 40.w,
          ),
          GoldText(
            text: text,
            fontSize: 10.sp,
          )
        ],
      ),
    );
  }
}
