import '../model/MusicLyrics.dart';
import '../model/MusicDetails.dart';
import 'package:http/http.dart' as http;
import '../model/MusicModel.dart';

class MusicProvider {
  Future<MusicModel> fetchMusic() async {
    print("Calling Api");
    try {
      final response = await http.get(
          "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=cfe1b2d39b8386968b1274d654efb483");

      print(response.statusCode);

      if (response.statusCode == 200) {
        final musicData = musicModelFromJson(response.body);
        return musicData;
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      return (e);
    }
  }

  Future<MusicDetailsModel> fetchMusicDetails({var trackID}) async {
    print("Calling Api");
    try {
      final response = await http.get(
          "https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackID&apikey=cfe1b2d39b8386968b1274d654efb483");

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final musicData = musicDetailsModelFromJson(response.body);
        return musicData;
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      return (e);
    }
  }

  Future<LyricsModel> fetchMusicLyrics({var trackID}) async {
    print("Calling Api");
    try {
      final response = await http.get(
          "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackID&apikey=cfe1b2d39b8386968b1274d654efb483");

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final musicData = lyricsModelFromJson(response.body);
        return musicData;
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      return (e);
    }
  }
}
