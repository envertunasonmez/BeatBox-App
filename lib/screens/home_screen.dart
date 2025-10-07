import 'package:beatbox_app/data/models/track_model.dart';
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

        return CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(12),
                  itemCount: state.tracks.length,
                  itemBuilder: (final BuildContext context, final int index) {
                    final Track track = state.tracks[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(track.albumCover, width: 140, height: 140, fit: BoxFit.cover),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 140,
                            child: Text(track.title, style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (final BuildContext context, final int index) {
                  return TrackTile(track: state.tracks[index]);
                },
                childCount: state.tracks.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
