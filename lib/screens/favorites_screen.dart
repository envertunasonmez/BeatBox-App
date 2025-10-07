import 'package:beatbox_app/data/models/track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beatbox_app/bloc/music_cubit.dart';
import 'package:beatbox_app/bloc/music_state.dart';
import 'package:beatbox_app/widgets/track_tile.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<MusicCubit, MusicState>(
      builder: (final BuildContext context, final MusicState state) {
        final List<Track> favoriteTracks = state.tracks
            .where((final Track track) => state.favoriteTrackIds.contains(track.id))
            .toList();
        if (favoriteTracks.isEmpty) {
          return const Center(child: Text("Favori şarkı yok"));
        }
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          itemCount: favoriteTracks.length,
          itemBuilder: (final BuildContext context, final int index) {
            return TrackTile(track: favoriteTracks[index]);
          },
        );
      },
    );
  }
}
