import 'package:empire_app_ui/components/components.dart';
import 'package:empire_app_ui/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TermsServiceDialog extends StatelessWidget {
  const TermsServiceDialog({Key? key}) : super(key: key);

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
              width: MediaQuery.of(context).size.width / 1.9,
              child: Image.asset(
                AppImages.termsServiceDialogBackground,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 2.h),
                  GoldText(
                    text:
                        "Using this application, you agree to our \n Terms & Policy",
                    fontSize: 15.sp,
                  ),

                  SizedBox(height: 0.5.h),

                  Text(
                    "This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You. You can find out more in our Privacy Policy in the link below:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "ElMessiri",
                      color: Colors.white,
                      fontSize: 8.sp,
                    ),
                  ),
                  
                  // SizedBox(height: 0.5.h),

                  GestureDetector(
                    onTap: () {
                      launchUrlString("https://warriorempires.io/policies", mode: LaunchMode.externalApplication);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(0.5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.openLink,
                            width: 9.sp,
                          ),
                          const SizedBox(width: 5),
                          GoldText(
                            text: "https://warriorempires.io/policies",
                            fontSize: 9.sp
                          )
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 1.h),

                  CommonButton(
                    text: "DONE",
                    onPress: () => clickDone(context),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  clickDone(BuildContext context) {
    Navigator.of(context).pop();
  }

  clickClose(BuildContext context) {
    Navigator.of(context).pop();
  }
}
