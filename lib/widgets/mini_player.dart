import 'package:beatbox_app/data/models/track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/music_cubit.dart';
import '../bloc/music_state.dart';
import 'album_cover_widget.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<MusicCubit, MusicState>(
      builder: (final BuildContext context, final MusicState state) {
        final Track? track = state.currentTrack;
        if (track == null) {
          return const SizedBox.shrink();
        }

        return Container(
          color: Colors.deepPurple.shade50,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  AlbumCoverWidget(imageUrl: track.albumCover),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(track.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(track.artist, style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(state.isPlaying ? Icons.pause_circle : Icons.play_circle),
                    iconSize: 36,
                    color: Colors.deepPurple,
                    onPressed: () => context.read<MusicCubit>().playTrack(track),
                  ),
                ],
              ),
              // Kontrol butonları
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(icon: const Icon(Icons.skip_previous), onPressed: () => context.read<MusicCubit>().playPrevious()),
                  IconButton(
                      icon: Icon(state.isShuffle ? Icons.shuffle_on : Icons.shuffle),
                      onPressed: () => context.read<MusicCubit>().toggleShuffle()),
                  IconButton(
                      icon: Icon(state.isRepeat ? Icons.repeat_on : Icons.repeat),
                      onPressed: () => context.read<MusicCubit>().toggleRepeat()),
                  IconButton(icon: const Icon(Icons.skip_next), onPressed: () => context.read<MusicCubit>().playNext()),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
