import 'package:empire_app_ui/constants/app_videos.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SmokeBackground extends StatefulWidget {
  const SmokeBackground({Key? key}) : super(key: key);

  @override
  State<SmokeBackground> createState() => _SmokeBackgroundState();
}

class _SmokeBackgroundState extends State<SmokeBackground> {
  late VideoPlayerController controller =
      VideoPlayerController.asset(AppVideos.smokeEffect);

  @override
  void initState() {
    super.initState();

    _initVideo();
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: MediaQuery.of(context).size.width /
                  MediaQuery.of(context).size.height,
              child: Opacity(
                opacity: 0.7,
                child: VideoPlayer(controller),
              ),
            )
          : Container(color: Colors.black.withOpacity(0.7)),
    );
  }

  _initVideo() async {
    await controller.initialize().then((value) {
      setState(() {});
    });
    controller.play();
    controller.setLooping(true);
    controller.setVolume(0);
  }
}
