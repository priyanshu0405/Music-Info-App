import '../model/MusicLyrics.dart';
import '../model/MusicDetails.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MusicDetailsBloc {
  final _repository = Repository();
  final _musicDetailsFetch = PublishSubject<MusicDetailsModel>();
  final _lyricsFetch = PublishSubject<LyricsModel>();

  Stream<MusicDetailsModel> get musicDetails => _musicDetailsFetch.stream;
  fetchMusicDetails({trackID}) async {
    MusicDetailsModel musicDetailsModel =
        await _repository.fetchMusicDetails(trackID: trackID);
    _musicDetailsFetch.sink.add(musicDetailsModel);
  }

  Stream<LyricsModel> get musicLyrics => _lyricsFetch.stream;
  fetchLyrics({trackID}) async {
    LyricsModel lyricsModel =
        await _repository.fetchMusicLyrics(trackID: trackID);
    _lyricsFetch.sink.add(lyricsModel);
  }

  disposeMusicDetailsStream() {
    print("Stream dispoed");
    _musicDetailsFetch.close();
  }

  disposeLyricsStream() {
    print("Stream dispoed");
    _lyricsFetch.close();
  }
}

final musicDetailsbloc = MusicDetailsBloc();
