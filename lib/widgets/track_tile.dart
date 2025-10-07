import 'package:beatbox_app/data/models/track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/music_cubit.dart';
import '../bloc/music_state.dart';
import 'album_cover_widget.dart';

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

        return LayoutBuilder(builder: (final BuildContext context, final BoxConstraints constraints) {
          final bool isWide = constraints.maxWidth > 600;
          return ListTile(
            leading: AlbumCoverWidget(imageUrl: track.albumCover),
            title: Text(track.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(track.artist),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                  onPressed: () => context.read<MusicCubit>().toggleFavorite(track),
                ),
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
                  iconSize: isWide ? 40 : 32,
                  color: Colors.deepPurple,
                  onPressed: () => context.read<MusicCubit>().playTrack(track),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
