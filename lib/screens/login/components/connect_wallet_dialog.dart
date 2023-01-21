
import 'package:empire_app_ui/constants/app_images.dart';
import 'package:empire_app_ui/screens/login/components/connect_wallet_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ConnectWalletDialog extends StatelessWidget {
  final Function doAfterConnectSuccess;

  const ConnectWalletDialog({
    Key? key,
    required this.doAfterConnectSuccess,
  }) : super(key: key);

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
              width: 50.w,
              child: Image.asset(AppImages.connectWalletDialogBackground),
            ),
            SizedBox(
              width: 37.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 2.h),
                  Image.asset(
                    AppImages.textWarriorEmpire,
                    width: 35.w,
                  ),
                  SizedBox(height: 2.5.h),
                  Row(
                    children: [
                      Image.asset(
                        AppImages.iconMuseum,
                        width: 5.w,
                      ),
                      SizedBox(width: 2.w),
                      Flexible(
                        child: Text(
                          "Let in see your wallet balance and activity",
                          style: TextStyle(
                            fontFamily: "ElMessiri",
                            color: Colors.white,
                            fontSize: 7.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Row(
                    children: [
                      Image.asset(
                        AppImages.iconBadgeCheck,
                        width: 5.w,
                      ),
                      SizedBox(width: 2.w),
                      Flexible(
                        child: Text(
                          "Let it send you requests for transactions",
                          style: TextStyle(
                            fontFamily: "ElMessiri",
                            color: Colors.white,
                            fontSize: 7.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Row(
                    children: [
                      Image.asset(
                        AppImages.iconBadgeDecline,
                        width: 5.w,
                      ),
                      SizedBox(width: 2.w),
                      Flexible(
                        child: Text(
                          "It cannot move funds without your permission",
                          style: TextStyle(
                            fontFamily: "ElMessiri",
                            color: Colors.white,
                            fontSize: 7.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                  
                  SizedBox(height: 3.h),
                  
                  ConnectWalletButton(doAfterConnectSuccess: () {
                    doAfterConnectSuccess();
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
