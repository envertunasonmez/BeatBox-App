import 'package:beatbox_app/data/models/track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beatbox_app/bloc/music_cubit.dart';
import 'package:beatbox_app/bloc/music_state.dart';
import 'package:beatbox_app/widgets/album_cover_widget.dart';

class TrackTile extends StatelessWidget {
  const TrackTile({required this.track, super.key});
  final Track track;

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<MusicCubit, MusicState>(
      builder: (final BuildContext context, final MusicState state) {
        final bool isCurrent = state.currentTrack?.id == track.id;
        final bool isPlaying = isCurrent && state.isPlaying;
        final bool isFavorite = state.favoriteTrackIds.contains(track.id);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              AlbumCoverWidget(imageUrl: track.albumCover),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      track.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      track.artist,
                      style: const TextStyle(color: Colors.white70),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.greenAccent,
                ),
                onPressed: () =>
                    context.read<MusicCubit>().toggleFavorite(track),
              ),
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause_circle : Icons.play_circle,
                  color: Colors.greenAccent,
                ),
                onPressed: () => context.read<MusicCubit>().playTrack(track),
              ),
            ],
          ),
        );
      },
    );
  }
}
