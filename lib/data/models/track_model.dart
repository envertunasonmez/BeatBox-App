class Track {

  Track({
    required this.id,
    required this.title,
    required this.artist,
    required this.albumCover,
    required this.previewUrl,
  });

  factory Track.fromJson(final Map<String, dynamic> json) {
    return Track(
      id: json['id'],
      title: json['title'],
      artist: json['artist']['name'],
      albumCover: json['album']['cover_medium'],
      previewUrl: json['preview'],
    );
  }
  final int id;
  final String title;
  final String artist;
  final String albumCover;
  final String previewUrl;
}
