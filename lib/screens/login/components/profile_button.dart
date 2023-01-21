import 'package:empire_app_ui/components/components.dart';
import 'package:empire_app_ui/screens/login/components/profile_dialog.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
const ProfileButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return CommonButton(
      text: "Profile",
      onPress: () {
        _showProfileDialog(context);
      },
    );
  }

  _showProfileDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return const ProfileDialog();
      },
    );
  }
}