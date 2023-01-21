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

class SignupForm extends StatefulWidget {
  final VoidCallback toggleVisibility;

  const SignupForm({
    Key? key,
    required this.toggleVisibility,
  }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      width: MediaQuery.of(context).size.width,
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
            width: 100.w,
            child: Image.asset(AppImages.signUpBg),
          ),
          SizedBox(
            width: 80.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "ElMessiri",
                    color: const Color(0xFFc4ccd0),
                    fontSize: 10.sp,
                  ),
                ),
                FormTextfield(placeholder: "Name", controller: nameController,),

                SizedBox(height: 1.5.h),

                Text(
                  "Email*",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "ElMessiri",
                    color: const Color(0xFFc4ccd0),
                        fontSize: 10.sp,
                  ),
                ),
                FormTextfield(placeholder: "Email", controller: emailController,),

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

                // SizedBox(height: 1.5.h),
                
                GestureDetector(
                  onTap: () {
                    setState(() {
                      accepted = !accepted;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              AppImages.checkboxBackground,
                              width: 5.w,
                            ),
                            accepted ? Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: 
                                Image.asset(
                                  AppImages.checkboxTick,
                                ),
                            ) : const SizedBox()
                          ],
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "I agree to terms & policy",
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.white,
                            fontFamily: "ElMessiri"
                          )
                        )
                      ],
                    ),
                  ),
                ),

                // SizedBox(height: 1.5.h),

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
  
  clickClose(BuildContext context) {
    widget.toggleVisibility();
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

    if(!accepted) {
      return Fluttertoast.showToast(
        msg: "Please accept our terms & policy to signup!",
      );
    }

    Logger().d({
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    });

    BlocProvider.of<AuthCubit>(context).signup(nameController.text, emailController.text, passwordController.text);
  }
}
