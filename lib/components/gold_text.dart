import 'package:flutter/material.dart';

class GoldText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final LinearGradient gradient;

  const GoldText({
    Key? key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w700,
    this.gradient = const LinearGradient(
      colors: [
        Color(0xFF5E5B56),
        Color(0xFFFFFEFD),
        Color(0xFF44423D),
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "ElMessiri",
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight,
          shadows: [
            Shadow(
              blurRadius: 10,
              color: const Color(0xFF7A0080).withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
