import 'package:empire_app_ui/components/common_button.dart';
import 'package:empire_app_ui/screens/login/components/components.dart';
import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final VoidCallback doAfterConnectSuccess;

  const StartButton({Key? key, required this.doAfterConnectSuccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      // text: "Connect wallet",
      text: "Let's War",
      onPress: () => _clickStart(context),
    );
  }

  _clickStart(BuildContext context) {
    // if (!_connected) {
      // _showConnectWalletDialog(context);
    // } else {
      _showJoinBetaDialog(context);
    // }
  }

  _showConnectWalletDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return ConnectWalletDialog(
          doAfterConnectSuccess:doAfterConnectSuccess,
        );
      },
    );
  }

  _showJoinBetaDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return const JoinBetaDialog();
      },
    );
  }
}
