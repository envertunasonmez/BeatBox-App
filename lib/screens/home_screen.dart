import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/music_cubit.dart';
import '../bloc/music_state.dart';
import '../widgets/track_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<MusicCubit, MusicState>(
      builder: (final BuildContext context, final MusicState state) {
        if (state.tracks.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return LayoutBuilder(
          builder: (final BuildContext context, final BoxConstraints constraints) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: state.tracks.length,
              itemBuilder: (final BuildContext context, final int index) {
                return TrackTile(track: state.tracks[index]);
              },
            );
          },
        );
      },
    );
  }
}
