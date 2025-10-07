import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beatbox_app/bloc/music_cubit.dart';
import 'package:beatbox_app/bloc/music_state.dart';
import 'package:beatbox_app/widgets/album_cover_widget.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<MusicCubit, MusicState>(
      builder: (final context, final state) {
        final track = state.currentTrack;
        if (track == null) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 70,
          color: const Color(0xFF1E1E1E),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AlbumCoverWidget(
                  imageUrl: track.albumCover,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(track.title,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis),
                    Text(track.artist,
                        style: const TextStyle(color: Colors.white70),
                        overflow: TextOverflow.ellipsis),
                    // Mini wave progress
                    SizedBox(
                      height: 4,
                      child: LinearProgressIndicator(
                        value: state.isPlaying ? 0.5 : 0, // Örnek ilerleme
                        color: Colors.greenAccent,
                        backgroundColor: Colors.white12,
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white),
                onPressed: () => context.read<MusicCubit>().playPrevious(),
              ),
              IconButton(
                icon: Icon(
                    state.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                    color: Colors.greenAccent,
                    size: 36),
                onPressed: () => context.read<MusicCubit>().playTrack(track),
              ),
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white),
                onPressed: () => context.read<MusicCubit>().playNext(),
              ),
            ],
          ),
        );
      },
    );
  }
}
