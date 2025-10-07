import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:beatbox_app/data/models/track_model.dart';

class ApiService {
  static const String popularUrl = "https://api.deezer.com/chart/0/tracks";

  Future<List<Track>> fetchPopularTracks() async {
    final http.Response response = await http.get(Uri.parse(popularUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List tracksJson = data['data'];
      return tracksJson.map((final json) => Track.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tracks');
    }
  }

  Future<List<Track>> searchTracks(final String query) async {
    final http.Response response = await http.get(Uri.parse(
        'https://api.deezer.com/search?q=${Uri.encodeComponent(query)}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List tracksJson = data['data'];
      return tracksJson.map((final json) => Track.fromJson(json)).toList();
    } else {
      throw Exception('Search failed');
    }
  }
}
