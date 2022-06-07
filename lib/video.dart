import 'package:feedbackdashboard/color_manager.dart';
import 'package:feedbackdashboard/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoAppOne extends StatefulWidget {
  const VideoAppOne({
    Key? key,
    required this.url,
    required this.title,
  }) : super(key: key);
  final String url;
  final String title;
  @override
  // ignore: library_private_types_in_public_api
  _VideoAppOneState createState() => _VideoAppOneState();
}

class _VideoAppOneState extends State<VideoAppOne> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: ColorManager.skyBlue,
      title: Center(
        child: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeightManager.medium,
            fontSize: 26,
            color: ColorManager.white,
          ),
        ),
      ),
      children: [
        SimpleDialogOption(
          child: Center(
            child: SizedBox(
              height: 500,
              width: 400,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
          ),
        ),
        SimpleDialogOption(
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: ColorManager.white,
            ),
          ),
        ),
        SimpleDialogOption(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cancel,
                color: ColorManager.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Cancel',
                style: TextStyle(
                  fontWeight: FontWeightManager.medium,
                  fontSize: 20,
                  color: ColorManager.white,
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
