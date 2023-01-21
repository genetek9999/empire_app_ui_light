import 'package:empire_app_ui/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

enum Tab {
  lordNfts,
  landNfts,
}

final listLand = [
  AppImages.profileLand1,
  AppImages.profileLand2,
  AppImages.profileLand3,
  AppImages.profileLand4,
  AppImages.profileLand5,
  AppImages.profileLand6,
  AppImages.profileLand7
];

final listLord = [
  AppImages.profileLord1,
  AppImages.profileLord2,
  AppImages.profileLord3,
  AppImages.profileLord4,
  AppImages.profileLord5,
  AppImages.profileLord6,
  AppImages.profileLord7
];

class ProfileDialog extends StatefulWidget {
  const ProfileDialog({ Key? key }) : super(key: key);

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  Tab activeTab = Tab.lordNfts;

  @override
  Widget build(BuildContext context){
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
              width: MediaQuery.of(context).size.width / 1.2,
              child: Image.asset(AppImages.profileDialogBackground),
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 2.h),

                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if(activeTab != Tab.lordNfts) {
                                setState(() {
                                  activeTab = Tab.lordNfts;
                                });
                              }
                            },
                            child: Opacity(
                              opacity: activeTab == Tab.lordNfts ? 1 : 0.5,
                              child: Image.asset(
                                AppImages.profileLordNftsButton,
                                width: 16.w,
                              ),
                            ),
                          ),

                          SizedBox(width: 2.w),

                          GestureDetector(
                            onTap: () {
                              if(activeTab != Tab.landNfts) {
                                setState(() {
                                  activeTab = Tab.landNfts;
                                });
                              }
                            },
                            child: Opacity(
                              opacity: activeTab == Tab.landNfts ? 1 : 0.5,
                              child: Image.asset(
                                AppImages.profileLandNftsButton,
                                width: 16.w,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 1.h),

                      Stack(
                        children: [
                          Image.asset(
                            AppImages.profileClaimBackground,
                            width: 34.w,
                          ),
                          Positioned(
                            bottom: 2.h,
                            left: 8.w,
                            right: 8.w,
                            child: Image.asset(
                              AppImages.profileClaimButton,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 1.h),

                      Stack(
                        children: [
                          Image.asset(
                            AppImages.profileWalletInfo,
                            width: 34.w,
                          ),
                          Positioned(
                            bottom: 0.9.h,
                            right: 5.w,
                            child: Text(
                              "0x4d3...5a09",
                              style: TextStyle(
                                fontFamily: "ElMessiri",
                                fontSize: 7.sp,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(width: 5.w),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Stack(
                        children: [
                          Image.asset(
                            AppImages.profileListNftBackground,
                            width: 126.5.w,
                            height: MediaQuery.of(context).size.height / 1.3,
                            fit: BoxFit.fill,
                          ),

                          Positioned(
                            top: 1.h,
                            left: 1.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    for(int i = 0; i < 5; i++)
                                      Row(
                                        children: [
                                          Image.asset(
                                            activeTab == Tab.landNfts ? listLand[i] : listLord[i],
                                            width: 23.w,
                                            fit: BoxFit.fitWidth,
                                          ),
                                          SizedBox(width: 0.9.h),
                                        ],
                                      )
                                  ],
                                ),

                                SizedBox(height: 0.8.h),

                                Row(
                                  children: [
                                    for(int i = 5; i < 7; i++)
                                      Row(
                                        children: [
                                          Image.asset(
                                            activeTab == Tab.landNfts ? listLand[i] : listLord[i],
                                            width: 23.w,
                                            fit: BoxFit.fitWidth,
                                          ),
                                          SizedBox(width: 0.9.h),
                                        ],
                                      )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )
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