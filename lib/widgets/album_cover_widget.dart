import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/music_cubit.dart';
import '../bloc/music_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AlbumCoverWidget extends StatefulWidget {
  const AlbumCoverWidget({required this.imageUrl, super.key});
  final String imageUrl;

  @override
  State<AlbumCoverWidget> createState() => _AlbumCoverWidgetState();
}

class _AlbumCoverWidgetState extends State<AlbumCoverWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<MusicCubit, MusicState>(
      builder: (final BuildContext context, final MusicState state) {
        final bool isPlaying = state.isPlaying && state.currentTrack?.albumCover == widget.imageUrl;
        return RotationTransition(
          turns: isPlaying ? _controller : const AlwaysStoppedAnimation(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
