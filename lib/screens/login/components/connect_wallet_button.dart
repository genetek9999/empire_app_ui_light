import 'dart:io';

import 'package:empire_app_ui/components/common_button.dart';
import 'package:empire_app_ui/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:logger/logger.dart';

class ConnectWalletButton extends StatefulWidget {
  final VoidCallback doAfterConnectSuccess;

  const ConnectWalletButton({Key? key, required this.doAfterConnectSuccess}) : super(key: key);

  @override
  State<ConnectWalletButton> createState() => _ConnectWalletButtonState();
}

class _ConnectWalletButtonState extends State<ConnectWalletButton> {
  late WalletConnect walletConnect;
  late int chainId;
  late String minter;
  String statusMessage = 'Initialized';

  Future<void> initWalletConnect() async {
    // Wallet Connect Session Storage - So we can persist connections
    final sessionStorage = WalletConnectSecureStorage();
    final session = await sessionStorage.getSession();

    // Create a connector
    walletConnect = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      session: session,
      sessionStorage: sessionStorage,
      clientMeta: const PeerMeta(
        name: 'Warrior Empires',
        url: 'https://warriorempires.io',
        icons: ['https://warriorempires.io/favicon.ico'],
      ),
    );

    // Did we restore a session?
    if (session != null) {
      Logger().d(
          "WalletConnect - Restored  v${session.version} session: ${session.accounts.length} account(s), bridge: ${session.bridge} connected: ${session.connected}, clientId: ${session.clientId}");

      if (session.connected) {
        Logger().d(
            'WalletConnect - Attempting to reuse existing connection for chainId ${session.chainId} and wallet address ${session.accounts[0]}.');
        setState(() {
          minter = session.accounts[0];
          chainId = session.chainId;
        });
      }
    } else {
      Logger().w(
          'WalletConnect - No existing sessions.  User needs to connect to a wallet.');
    }

    walletConnect.registerListeners(
      onConnect: (status) {
        // Status is updated, but session.peerinfo is not yet available.
        Logger().d(
            'WalletConnect - onConnect - Established connection with  Wallet app: ${walletConnect.session.peerMeta?.name} -${walletConnect.session.peerMeta?.description}');

        setState(() {
          statusMessage =
              'WalletConnect session established with ${walletConnect.session.peerMeta?.name} - ${walletConnect.session.peerMeta?.description}.';
        });

        // Did the user select a new chain?
        if (chainId != status.chainId) {
          Logger().d(
              'WalletConnect - onConnect - Selected blockchain has changed: chainId: $chainId <- ${status.chainId})');
          setState(() {
            chainId = status.chainId;
          });
        }

        // Did the user select a new wallet address?
        if (minter != status.accounts[0]) {
          Logger().d(
              'WalletConnect - onConnect - Selected wallet has changed: minter: $minter <- ${status.accounts[0]}');
          setState(() {
            minter = status.accounts[0];
          });
        }
      },
      onSessionUpdate: (status) {
        // What information is available?
        //print('WalletConnect - Updated session. $status');

        Logger().d(
            'WalletConnect - onSessionUpdate - Wallet ${walletConnect.session.peerMeta?.name} - ${walletConnect.session.peerMeta?.description}');

        setState(() {
          statusMessage =
              'WalletConnect - SessionUpdate received with chainId ${status.chainId} and account ${status.accounts[0]}.';
        });

        // Did the user select a new chain?
        if (chainId != status.chainId) {
          Logger().d(
              'WalletConnect - onSessionUpdate - Selected blockchain has changed: chainId: $chainId <- ${status.chainId}');
          setState(() {
            chainId = status.chainId;
          });
        }

        // Did the user select a new wallet address?
        if (minter != status.accounts[0]) {
          Logger().d(
              'WalletConnect - onSessionUpdate - Selected wallet has changed: minter: $minter <- ${status.accounts[0]}');
          setState(() {
            minter = status.accounts[0];
          });
        }
      },
      onDisconnect: () async {
        Logger().d(
            'WalletConnect - onDisconnect - minter: $minter <- "Please Connect Wallet"');
        setState(() {
          minter = 'Please Connect Wallet';
          statusMessage = 'WalletConnect session disconnected.';
        });
        await initWalletConnect();
      },
    );
  }

  Future<void> createWalletConnectSession(BuildContext context) async {
    // Create a new session
    if (walletConnect.connected) {
      statusMessage =
          'Already connected to ${walletConnect.session.peerMeta?.name} \n${walletConnect.session.peerMeta?.description}\n${walletConnect.session.peerMeta?.url}';
      Logger().d(
          'createWalletConnectSession - WalletConnect Already connected to ${walletConnect.session.peerMeta?.name} with minter: $minter, chainId $chainId. Ignored.');
      return;
    }

    // IOS users will need to be prompted which wallet to use.
    if (Platform.isIOS) {
      // List<WalletConnectRegistryListing> listings = await readWalletRegistry(limit: 4);

      // await showModalBottomSheet(
      //   context: context,
      //   builder: (context) {
      //     return showIOSWalletSelectionDialog(context, listings, setWalletListing);
      //   },
      //   isScrollControlled: true,
      //   isDismissible: false,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      // );
    }

    Logger().d('createWalletConnectSession');
    SessionStatus session;
    try {
      session = await walletConnect.createSession(
          chainId: 1,
          onDisplayUri: (uri) async {
            setState(() {
              Logger().d('_displayUri updated with $uri');
            });

            // Open any registered wallet via wc: intent
            bool? result;

            // IOS users have already chosen wallet, so customize the launcher
            if (Platform.isIOS) {
              // uri = walletListing.mobile.universal + '/wc?uri=${Uri.encodeComponent(uri)}';
            }
            // Else
            // - Android users will choose their walled from the OS prompt

            Logger().d('launching uri: $uri');
            try {
              result = await launchUrl(Uri.parse(uri),
                  mode: LaunchMode.externalApplication);
              if (result == false) {
                // launch alternative method
                Logger().e(
                    'Initial launchuri failed. Fallback launch with forceSafariVC true');
                result = await launchUrl(Uri.parse(uri));
                if (result == false) {
                  Logger().e('Could not launch $uri');
                }
              }
              if (result) {
                setState(() {
                  statusMessage = 'Launched wallet app, requesting session.';
                });
              }
            } on PlatformException catch (e) {
              if (e.code == 'ACTIVITY_NOT_FOUND') {
                Logger().w('No wallets available - do nothing!');
                setState(() {
                  statusMessage =
                      'ERROR - No WalletConnect compatible wallets found.';
                });
                return;
              }
              Logger().e('launch returned $result');
              Logger().e(
                  'Unexpected PlatformException error: ${e.message}, code: ${e.code}, details: ${e.details}');
            } on Exception catch (e) {
              Logger().e('launch returned $result');
              Logger().e('url launcher other error e: $e');
            }
          });
    } catch (e) {
      Logger().e('Unable to connect - killing the session on our side.');
      statusMessage = 'Unable to connect - killing the session on our side.';
      walletConnect.killSession();
      return;
    }
    if (session.accounts.isEmpty) {
      statusMessage =
          'Failed to connect to wallet.  Bridge Overloaded? Could not Connect?';

      // wc:f54c5bca-7712-4187-908c-9a92aa70d8db@1?bridge=https%3A%2F%2Fz.bridge.walletconnect.org&key=155ca05ffc2ab197772a5bd56a5686728f9fcc2b6eee5ffcb6fd07e46337888c
      Logger().e(
          'Failed to connect to wallet.  Bridge Overloaded? Could not Connect?');
    }
  }

  @override
  void initState() {
    super.initState();

    initWalletConnect();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonButton(
          text: "Connect Wallet",
          onPress: () {
            // createWalletConnectSession(context);
            Navigator.of(context).pop();
            widget.doAfterConnectSuccess();
          },
        ),
      ],
    );
  }
}
