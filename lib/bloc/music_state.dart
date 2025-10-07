import 'package:beatbox_app/data/models/track_model.dart';


class MusicState {

  MusicState({
    required this.tracks,
    this.currentTrack,
    this.isPlaying = false,
    this.favoriteTrackIds = const [],
    this.isShuffle = false,
    this.isRepeat = false,
  });
  final List<Track> tracks;
  final Track? currentTrack;
  final bool isPlaying;
  final List<int> favoriteTrackIds;
  final bool isShuffle;
  final bool isRepeat;

  MusicState copyWith({
    final List<Track>? tracks,
    final Track? currentTrack,
    final bool? isPlaying,
    final List<int>? favoriteTrackIds,
    final bool? isShuffle,
    final bool? isRepeat,
  }) {
    return MusicState(
      tracks: tracks ?? this.tracks,
      currentTrack: currentTrack ?? this.currentTrack,
      isPlaying: isPlaying ?? this.isPlaying,
      favoriteTrackIds: favoriteTrackIds ?? this.favoriteTrackIds,
      isShuffle: isShuffle ?? this.isShuffle,
      isRepeat: isRepeat ?? this.isRepeat,
    );
  }
}
