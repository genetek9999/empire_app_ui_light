import 'package:empire_app_ui/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher_string.dart';

const String discordURL = "https://discord.com/invite/warriorempires";
const String websiteURL = "https://warriorempires.io";
const String twitterURL = "https://twitter.com/WARRIOREMPIRES";

Widget socialButtons(BuildContext context) {
  openLink(String urlString) async {
    try {
      await launchUrlString(
        urlString,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      Logger().e(e);
    }
  }

  return Stack(
    alignment: Alignment.center,
    children: [
      Image.asset(
        AppImages.socialButtonsBackground,
        width: MediaQuery.of(context).size.height / 8,
      ),
      Column(
        children: [
          GestureDetector(
            onTap: () => openLink(discordURL),
            child: Image.asset(
              AppImages.discord,
              width: MediaQuery.of(context).size.height / 15,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => openLink(websiteURL),
            child: Image.asset(
              AppImages.website,
              width: MediaQuery.of(context).size.height / 15,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => openLink(twitterURL),
            child: Image.asset(
              AppImages.twitter,
              width: MediaQuery.of(context).size.height / 15,
              fit: BoxFit.cover,
            ),
          )
        ],
      )
    ],
  );
}
