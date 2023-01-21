import 'package:empire_app_ui/components/components.dart';
import 'package:empire_app_ui/constants/constants.dart';
import 'package:empire_app_ui/cubits/auth/auth_cubit.dart';
import 'package:empire_app_ui/helpers/shared_preferences.dart';
import 'package:empire_app_ui/screens/login/components/components.dart';
import 'package:empire_app_ui/screens/login/components/login_form.dart';
import 'package:empire_app_ui/screens/login/components/profile_button.dart';
import 'package:empire_app_ui/screens/login/components/sign_up_form.dart';
import 'package:empire_app_ui/screens/login/components/start_button.dart';
import 'package:empire_app_ui/screens/login/components/terms_service_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indexed/indexed.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = true;
  bool visibleLogin = false;
  bool visibleSignup = false;
  bool authSuccess = false;
  bool connectSuccess = false;
  bool loadingJoinGame = false;

  @override
  void initState() {
    super.initState();

    initAuth();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) => state.whenOrNull(
        loading: () {
          return context.loaderOverlay.show();
        },
        success: () {
          setState(() {
            authSuccess = true;
            visibleLogin = false;
            visibleSignup = false;
          });

          SharedPreferencesHelper.setString(AppKeys.accessToken, "warrior_empires");

          return context.loaderOverlay.hide();
        },
        error: (error) {
          Fluttertoast.showToast(msg: error);
          return context.loaderOverlay.hide();
        }
      ),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: LoaderOverlay(
            overlayColor: Colors.black,
            useDefaultLoading: false,
            overlayWidget: const Center(
              child: SpinKitSpinningLines(
                color: Color(0xFFA52A2A),
                size: 50.0,
              ),
            ),
            child: Indexer(
              children: [
                /**
                 * !Background Image
                 */
                Image.asset(
                  AppImages.bannerMobile,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                /**
                 * !Smoke effect
                 */
                const SmokeBackground(),
                /**
                 * !Bottom-left Warrior Image
                 */
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Image.asset(
                    AppImages.warriorRed,
                    height: MediaQuery.of(context).size.height * 3 / 5,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                /**
                 * !Bottom-right Warrior Image
                 */
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    AppImages.warriorBlue,
                    height: MediaQuery.of(context).size.height * 3 / 5,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                /**
                 * !Top-left Flag Image
                 */
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    AppImages.flag,
                    height: MediaQuery.of(context).size.height * 1 / 3,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                /**
                 * !Top-right Compass Image
                 */
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    AppImages.compass,
                    height: MediaQuery.of(context).size.height * 1 / 3,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                /**
                 * !Top-center Badge Image
                 */
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    AppImages.badge,
                    height: MediaQuery.of(context).size.height * 4 / 5,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                /**
                 * !Loading bar
                 */
                (() {
                  if (!loading && !loadingJoinGame) return const SizedBox();
    
                  return Positioned(
                    bottom: MediaQuery.of(context).size.height / 30,
                    left: 0,
                    right: 0,
                    child: LoadingBar(
                      loadingJoinGame: loadingJoinGame,
                      stopLoading: () {
                        setState(() {
                          loading = false;
                          loadingJoinGame = false;
                        });
                      },
                    ),
                  );
                }()),
                /**
                 * !Social buttons
                 */
                Positioned(
                  top: MediaQuery.of(context).size.height / 10,
                  left: MediaQuery.of(context).size.height / 20,
                  child: socialButtons(context),
                ),
                /**
                 * !App version
                 */
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 20,
                  right: MediaQuery.of(context).size.height / 20,
                  child: Text(
                    "Beta v2 2023738217",
                    style: TextStyle(
                      fontFamily: "ElMessiri",
                      fontSize: 8.sp,
                      color: const Color(0xFFB9B9B9),
                      // color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                
                /**
                 * !Terms & Service Button
                 */
                Positioned(
                  top: MediaQuery.of(context).size.height / 25,
                  right: MediaQuery.of(context).size.height / 25,
                  child: const TermsServiceButton(),
                ),
    
                /**
                 * !Connect wallet button
                 */
                (!loading && authSuccess && !connectSuccess) ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: MediaQuery.of(context).size.height / 7,
                  child: StartButton(doAfterConnectSuccess: doAfterConnectSuccess),
                ) : const SizedBox(),
                
                /**
                 * !Auth buttons
                 */
                (!loading && !authSuccess) ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: MediaQuery.of(context).size.height / 7,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonButton(
                          text: "Login",
                          onPress: () => toggleVisibleLogin(),
                        ),
    
                        SizedBox(width: MediaQuery.of(context).size.width / 50),
    
                        CommonButton(
                          text: "Sign Up",
                          onPress: () => toggleVisibleSignup(),
                        ),
                      ],
                    ),
                  ),
                ) : const SizedBox(),
                
                /**
                 * !Ingame buttons
                 */
                (!loading && authSuccess && connectSuccess && !loadingJoinGame) ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: MediaQuery.of(context).size.height / 7,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonButton(
                          text: "Let's War",
                          onPress: () {
                            setState(() {
                              loadingJoinGame = true;
                            });
                          },
                        ),
    
                        SizedBox(width: MediaQuery.of(context).size.width / 50),
    
                        const ProfileButton(),
                      ],
                    ),
                  ),
                ) : const SizedBox(),
    
                Indexed(
                  index: visibleLogin ? 10 : 0,
                  child: LoginForm(
                          toggleVisibility: () => toggleVisibleLogin(),
                        ),
                ),
    
                Indexed(
                  index: visibleSignup ? 10 : 0,
                  child: SignupForm(
                          toggleVisibility: () => toggleVisibleSignup(),
                        ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  initAuth() async {
    String accessToken = await SharedPreferencesHelper.getString(AppKeys.accessToken);

    if(accessToken == "warrior_empires") {
      setState(() {
        authSuccess = true;
      });
    }
  }

  toggleVisibleLogin() {
    if (visibleLogin) {
      setState(() {
        visibleLogin = false;
      });
    } else {
      setState(() {
        visibleLogin = true;
      });
    }
  }

  toggleVisibleSignup() {
    if (visibleSignup) {
      setState(() {
        visibleSignup = false;
      });
    } else {
      setState(() {
        visibleSignup = true;
      });
    }
  }

  doAfterConnectSuccess() {
    setState(() {
      connectSuccess = true;
    });
  }
}
