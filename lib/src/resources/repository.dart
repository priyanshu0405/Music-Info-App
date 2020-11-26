import '../model/MusicLyrics.dart';
import '../model/MusicDetails.dart';
import '../model/MusicModel.dart';
import '../resources/song_api_provider.dart';

class Repository {
  final musicProvider = MusicProvider();
  Future<MusicModel> fetchMusic() => musicProvider.fetchMusic();
  Future<MusicDetailsModel> fetchMusicDetails({trackID}) =>
      musicProvider.fetchMusicDetails(trackID: trackID);
  Future<LyricsModel> fetchMusicLyrics({trackID}) =>
      musicProvider.fetchMusicLyrics(trackID: trackID);
}
