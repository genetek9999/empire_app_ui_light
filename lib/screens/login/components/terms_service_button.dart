import 'package:empire_app_ui/components/components.dart';
import 'package:empire_app_ui/constants/app_images.dart';
import 'package:empire_app_ui/screens/login/components/components.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TermsServiceButton extends StatelessWidget {
  const TermsServiceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTermsServiceDialog(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AppImages.termsServiceButtonBackground,
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.width / 22,
          ),
          GoldText(
            text: "Terms & Policy",
            fontSize: 10.sp,
          )
        ],
      ),
    );
  }

  _showTermsServiceDialog(BuildContext context) async {
    return showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return const TermsServiceDialog();
      },
    );
  }
}
