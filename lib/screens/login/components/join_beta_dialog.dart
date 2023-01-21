import 'package:empire_app_ui/components/components.dart';
import 'package:empire_app_ui/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

const String joinBetaURL = "https://warriorempires.io/signup-for-beta-3.0";

class JoinBetaDialog extends StatelessWidget {
  const JoinBetaDialog({Key? key}) : super(key: key);

  clickJoin() async {
    try {
      await launchUrlString(
        joinBetaURL,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      Logger().e(e);
    }
  }

  clickClose(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.5),
      insetPadding: const EdgeInsets.symmetric(vertical: 0),
      child: SizedBox(
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
              child: Image.asset(
                AppImages.betaDialogBackground,
              ),
            ),
            SizedBox(
              width: 85.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GoldText(
                    text: "Join Warrior Empires Beta 3.0",
                    fontSize: 14.sp,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Text(
                    "Dear player, we are sorry that you are not in the list for Beta 2.0 Trial, please follow and complete the missions at W.E discord to participate in the Warrior Empires Beta 3.0 . You may follow our community to get the latest news of testing and launch. See you in the near future!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "ElMessiri",
                      color: Colors.white,
                      fontSize: 7.5.sp,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 20),
                  CommonButton(
                    text: "Signup for Beta 3.0",
                    backgroundImage: AppImages.joinBetaButtonBackground,
                    onPress: () => clickJoin(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
