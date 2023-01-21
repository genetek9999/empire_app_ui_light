
import 'package:email_validator/email_validator.dart';
import 'package:empire_app_ui/components/components.dart';
import 'package:empire_app_ui/constants/app_images.dart';
import 'package:empire_app_ui/cubits/auth/auth_cubit.dart';
import 'package:empire_app_ui/screens/login/components/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:sizer/sizer.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback toggleVisibility;

  const LoginForm({
    Key? key,
    required this.toggleVisibility,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  clickClose(BuildContext context) {
    widget.toggleVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black.withOpacity(0.5),
        width: MediaQuery.of(context).size.width * 2,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => clickClose(context),
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(2.5.h),
                  child: Image.asset(
                    AppImages.closeButton,
                    width: 3.5.h,
                  ),
                ),
              ),
            ),
    
            SizedBox(
              width: 90.w,
              child: Image.asset(AppImages.loginBg),
            ),
    
            SizedBox(
              width: 70.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Email*",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "ElMessiri",
                      color: const Color(0xFFc4ccd0),
                      fontSize: 10.sp,
                    ),
                  ),
                  FormTextfield(placeholder: "Email", controller: emailController),
    
                  SizedBox(height: 1.5.h),
    
                  Text(
                    "Password*",
                    style: TextStyle(
                      fontFamily: "ElMessiri",
                      color: const Color(0xFFc4ccd0),
                          fontSize: 10.sp,
                    ),
                  ),
                  FormTextfield(placeholder: "Password", obscureText: true, controller: passwordController,),
    
                  SizedBox(height: 4.h),
    
                  Center(
                    child: CommonButton(
                      text: "Submit",
                      onPress: submitForm,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
  }

  submitForm() {
    if(emailController.text == "" || passwordController.text == "") {
      return Fluttertoast.showToast(
        msg: "Please enter required information!",
      );
    }

    if(!EmailValidator.validate(emailController.text)) {
      return Fluttertoast.showToast(
        msg: "Invalid email format!",
      );
    }

    Logger().d({
      "email": emailController.text,
      "password": passwordController.text,
    });

    BlocProvider.of<AuthCubit>(context).login(emailController.text, passwordController.text);
  }
}
