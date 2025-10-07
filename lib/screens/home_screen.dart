import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beatbox_app/bloc/music_cubit.dart';
import 'package:beatbox_app/bloc/music_state.dart';
import 'package:beatbox_app/widgets/track_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<MusicCubit, MusicState>(
      builder: (final BuildContext context, final MusicState state) {
        if (state.tracks.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF1DB954)),
          );
        }

        return Container(
          color: const Color(0xFF121212),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                backgroundColor: Colors.transparent,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        const Color(0xFF1DB954),
                        const Color(0xFF1DB954).withOpacity(0.8),
                        const Color(0xFF121212),
                      ],
                      stops: const <double>[0.0, 0.6, 1.0],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, // <<< Önemli
                        children: <Widget>[
                          Text(
                            _getGreeting(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text(
                    "Popüler Şarkılar",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.only(bottom: 140),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((final BuildContext context, final int index) {
                    return TrackTile(track: state.tracks[index]);
                  }, childCount: state.tracks.length),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getGreeting() {
    final int hour = DateTime.now().hour;
    if (hour < 12) {
      return "Günaydın";
    }
    if (hour < 17) {
      return "İyi öğleden sonralar";
    }
    if (hour < 21) {
      return "İyi akşamlar";
    }
    return "İyi geceler";
  }
}
