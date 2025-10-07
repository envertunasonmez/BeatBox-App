import 'package:beatbox_app/data/models/track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/music_cubit.dart';
import '../widgets/track_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Track> tracks = <Track>[];

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Şarkı, sanatçı veya albüm ara',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  final List<Track> result = await context.read<MusicCubit>().searchTracks(_controller.text);
                  setState(() => tracks = result);
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: tracks.isEmpty
              ? const Center(child: Text("Arama yapın"))
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: tracks.length,
                  itemBuilder: (final BuildContext context, final int index) {
                    return TrackTile(track: tracks[index]);
                  },
                ),
        ),
      ],
    );
  }
}
