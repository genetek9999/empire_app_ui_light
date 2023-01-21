import 'dart:async';

import 'package:empire_app_ui/components/components.dart';
import 'package:empire_app_ui/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingBar extends StatefulWidget {
  final VoidCallback stopLoading;
  final bool loadingJoinGame;

  const LoadingBar({
    Key? key,
    required this.stopLoading,
    required this.loadingJoinGame,
  }) : super(key: key);

  @override
  State<LoadingBar> createState() => _LoadingBarState();
}

class _LoadingBarState extends State<LoadingBar> {
  double progress = 0;

  @override
  void initState() {
    if(widget.loadingJoinGame) {
      _fakeProgress(10, 1, () {
        widget.stopLoading();
      });
    } else {
      _initFakeProgress();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double calculatedWidth =
        MediaQuery.of(context).size.width * (1.075 / 2) * progress;

    return Center(
      child: Stack(
        children: [
          /**
         * !Loading bar background
         */
          Image.asset(
            AppImages.loadingBarBackground,
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.width / 28,
          ),
          /**
         * !Loading bar core
         */
          Positioned(
            top: 1,
            bottom: 0,
            left: MediaQuery.of(context).size.width / 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.loadingCoreHead,
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Image.asset(
                  AppImages.loadingCoreBody,
                  width: calculatedWidth,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Image.asset(
                  AppImages.loadingCoreTail,
                  height: MediaQuery.of(context).size.width / 40,
                ),
              ],
            ),
          ),
          /**
         * !Loading bar layer
         */
          Image.asset(
            AppImages.loadingBarLayer,
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.width / 28,
          ),
          Positioned(
            top: 3,
            right: 0,
            left: 0,
            bottom: 0,
            child: Center(
              child: GoldText(
                text: "Loading ${(progress * 100).toInt()}%",
                fontSize: 8.sp,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF5E5B56),
                    Color(0xFF5E5B56),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _initFakeProgress() {
    _fakeProgress(100, 0.3, () {
      _fakeProgress(500, 0.35, () {
        _fakeProgress(300, 0.5, () {
          _fakeProgress(500, 0.55, () {
            _fakeProgress(200, 0.7, () {
              _fakeProgress(700, 0.75, () {
                _fakeProgress(300, 0.9, () {
                  _fakeProgress(1000, 0.95, () {
                    _fakeProgress(100, 1, () {
                      widget.stopLoading();
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
  }

  _fakeProgress(int durationMs, double stopVal, VoidCallback nextFunc) {
    Timer.periodic(
      Duration(milliseconds: durationMs),
      (timer) {
        setState(() {
          progress += 0.01;
        });

        if (progress >= stopVal) {
          setState(() {
            progress = stopVal;
          });

          timer.cancel();

          nextFunc();
        }
      },
    );
  }
}
