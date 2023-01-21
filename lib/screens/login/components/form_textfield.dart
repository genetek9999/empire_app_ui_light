import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:sizer/sizer.dart';

class FormTextfield extends StatelessWidget {
  final String placeholder;
  final bool obscureText;
  final TextEditingController controller;

  const FormTextfield({ Key? key, this.placeholder = "", this.obscureText = false, required this.controller }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return TextField(
      controller: controller,
      decoration:  InputDecoration(
        contentPadding:const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        isDense: true,
        border: const GradientOutlineInputBorder(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:  [Color(0xFF5E5B56), Color(0xFFFFFEFD),Color(0xFF44423D)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(0))
        ),
        hintText: placeholder,
        hintStyle: TextStyle(
          color: const Color.fromARGB(118, 196, 204, 208),
          fontFamily: "ElMessiri",
          fontSize: 10.sp,
        ),
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: 10.sp,
        fontFamily: "ElMessiri",
        height: 2.sp
      ),
      obscureText: obscureText
    );
  }
}