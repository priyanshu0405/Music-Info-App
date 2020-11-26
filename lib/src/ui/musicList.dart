import '../bloc/ConnectivityBloc.dart';
import '../bloc/musicBloc.dart';
import '../model/MusicModel.dart';
import 'musicDetails.dart';
import 'package:flutter/material.dart';

class MusicList extends StatefulWidget {
  static const routeName = "/MusicList";

  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  Widget build(BuildContext context) {
    bloc.fetchMusic(); //Function Call to sink data from api to stream
    connectivityBloc
        .connectivityStatus(); //Function Call to sink connectivity status to stream
    return Scaffold(
        backgroundColor: Color(0xFF090917),
        appBar: AppBar(
          backgroundColor: Color(0xFF9BAEF0),
          centerTitle: true,
          title: Text(
            "Top Songs",
            style: TextStyle(color: Color(0xFF090917)),
          ),
        ),
        body: StreamBuilder(
          stream:
              connectivityBloc.connectivityStatusCode, //Stream for connectivity
          builder: (context, AsyncSnapshot connectivitySnapshot) {
            return StreamBuilder(
              stream: bloc.music, //Stream for track data
              builder: (context, AsyncSnapshot<MusicModel> snapshot) {
                if (snapshot.hasData) {
                  return musicListUI(
                      snapshot: snapshot,
                      connectivitySnapshot:
                          connectivitySnapshot); //Track List Widget
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ));
  }

  Widget musicListUI(
      {AsyncSnapshot<MusicModel> snapshot,
      AsyncSnapshot connectivitySnapshot}) {
    return connectivitySnapshot.data == 2
        ? Center(
            child: Text("No Internet Connection"),
          )
        : ListView.separated(
            itemCount: snapshot.data.message.body.trackList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(MusicDetails.routeName,
                      arguments: snapshot
                          .data.message.body.trackList[index].track.trackId);
                },
                leading: Icon(
                  Icons.library_music,
                  color: Color(0xFF9BAEF0),
                ),
                title: Text(
                  snapshot.data.message.body.trackList[index].track.trackName,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                subtitle: Text(
                  snapshot.data.message.body.trackList[index].track.albumName,
                  style: TextStyle(color: Color(0xFF9BAEF0)),
                ),
                trailing: Container(
                  child: Center(
                    child: Text(
                      snapshot
                          .data.message.body.trackList[index].track.artistName,
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  height: double.infinity,
                  width: 50,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
  }
}
