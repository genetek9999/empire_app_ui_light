import 'package:empire_app_ui/cubits/auth/auth_cubit.dart';
import 'package:empire_app_ui/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

void main() { 
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
  ])
      .then(
        (value) => SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [],
        ),
      )
      .then(
        (value) => runApp(const MyApp()),
      );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit(),)
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Warrior Empires',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: const LoginScreen(),
          ),
        );
      }),
    );
  }
}
