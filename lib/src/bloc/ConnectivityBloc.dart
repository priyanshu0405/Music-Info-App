import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityBloc {
  final _connectivity = PublishSubject();
  StreamSubscription<ConnectivityResult> subscription;

  Stream get connectivityStatusCode => _connectivity.stream;

  connectivityStatus() async {
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      _connectivity.sink.add(event.index);
    });
  }

  dispose() {
    _connectivity.close();
    subscription.cancel();
  }
}

final connectivityBloc = ConnectivityBloc();
