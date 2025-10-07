import 'package:beatbox_app/data/models/track_model.dart';
import 'package:beatbox_app/data/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'music_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicCubit extends Cubit<MusicState> {

  MusicCubit() : super(MusicState(tracks: <Track>[])) {
    loadTracks();
    loadFavorites();
  }
  final ApiService _apiService = ApiService();
  final AudioPlayer player = AudioPlayer();

  Future<void> loadTracks() async {
    final List<Track> tracks = await _apiService.fetchPopularTracks();
    emit(state.copyWith(tracks: tracks));
  }

  Future<void> playTrack(final Track track) async {
    if (state.currentTrack?.id == track.id && state.isPlaying) {
      await player.pause();
      emit(state.copyWith(isPlaying: false));
    } else {
      await player.setUrl(track.previewUrl);
      await player.play();
      emit(state.copyWith(currentTrack: track, isPlaying: true));
    }
  }

  Future<void> toggleFavorite(final Track track) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<int> favs = List.from(state.favoriteTrackIds);
    if (favs.contains(track.id)) {
      favs.remove(track.id);
    } else {
      favs.add(track.id);
    }
    await prefs.setStringList('favorites', favs.map((final int e) => e.toString()).toList());
    emit(state.copyWith(favoriteTrackIds: favs));
  }

  Future<void> loadFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> list = prefs.getStringList('favorites') ?? <String>[];
    final List<int> favs = list.map((final String e) => int.parse(e)).toList();
    emit(state.copyWith(favoriteTrackIds: favs));
  }

  void toggleShuffle() => emit(state.copyWith(isShuffle: !state.isShuffle));
  void toggleRepeat() => emit(state.copyWith(isRepeat: !state.isRepeat));

  Future<void> playNext() async {
    if (state.tracks.isEmpty) {
      return;
    }
    final int index = state.tracks.indexWhere((final Track t) => t.id == state.currentTrack?.id);
    final int nextIndex = state.isShuffle ? (index + 1) % state.tracks.length : (index + 1) % state.tracks.length;
    await playTrack(state.tracks[nextIndex]);
  }

  Future<void> playPrevious() async {
    if (state.tracks.isEmpty) {
      return;
    }
    final int index = state.tracks.indexWhere((final Track t) => t.id == state.currentTrack?.id);
    final int prevIndex = (index - 1 + state.tracks.length) % state.tracks.length;
    await playTrack(state.tracks[prevIndex]);
  }

  Future<List<Track>> searchTracks(final String query) async {
    return await _apiService.searchTracks(query);
  }
}
