import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../entity/source_entity.dart';

class VideoItem extends StatefulWidget {
  final SourceEntity source;
  final bool? isFocus;
  const VideoItem({super.key, required this.source, this.isFocus});

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  VideoPlayerController? _controller;
  late VoidCallback listener;
  String? localFileName;
  _VideoItemState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }
  @override
  void initState() {
    super.initState();
    log('initState: ${widget.source.url}');
    init();
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose: ${widget.source.id}');
    _controller!.removeListener(listener);
    _controller?.pause();
    _controller?.dispose();
  }

  @override
  void didUpdateWidget(covariant VideoItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFocus! && !widget.isFocus!) {
      _controller?.pause();
    }
  }

  init() async {
    log("初始化视频: ${widget.source.url}");
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.source.url));
    // loop play
    _controller!.setLooping(true);
    await _controller!.initialize();
    _controller!.play();
    setState(() {});
    _controller!.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return _controller!.value.isInitialized
        ? Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _controller!.value.isPlaying
                        ? _controller!.pause()
                        : _controller!.play();
                  });
                },
                child: Hero(
                  tag: widget.source.id,
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                ),
              ),
              _controller!.value.isPlaying == true
                  ? const SizedBox()
                  : const IgnorePointer(
                      ignoring: true,
                      child: Icon(
                        Icons.play_arrow,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
            ],
          )
        : Theme(
            data: ThemeData(
                cupertinoOverrideTheme:
                    const CupertinoThemeData(brightness: Brightness.dark)),
            child: const CupertinoActivityIndicator(radius: 30));
    ;
  }
}
