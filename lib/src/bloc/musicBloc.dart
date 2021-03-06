import '../model/MusicModel.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MusicBloc {
  final _repository = Repository();
  final _musicFetch = PublishSubject<MusicModel>();

  Stream<MusicModel> get music => _musicFetch.stream;
  fetchMusic() async {
    MusicModel musicModel = await _repository.fetchMusic();
    _musicFetch.sink.add(musicModel);
  }

  dispose() {
    print("Stream dispoed");
    _musicFetch.close();
  }
}

final bloc = MusicBloc();
