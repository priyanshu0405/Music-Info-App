import '../bloc/ConnectivityBloc.dart';
import '../bloc/musicDetailBloc.dart';
import '../model/MusicLyrics.dart';
import '../model/MusicDetails.dart';
import 'package:flutter/material.dart';

class MusicDetails extends StatelessWidget {
  static const routeName = "/MusicDetail";

  @override
  Widget build(BuildContext context) {
    final trackID = ModalRoute.of(context).settings.arguments;
    connectivityBloc.connectivityStatus();
    musicDetailsbloc.fetchMusicDetails(trackID: trackID);
    musicDetailsbloc.fetchLyrics(trackID: trackID);
    return Scaffold(
      backgroundColor: Color(0xFF090917),
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Color(0xFF090917),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF9BAEF0),
        title: Text(
          "Title Details",
          style: TextStyle(color: Color(0xFF090917)),
        ),
      ),
      body: StreamBuilder(
        stream: connectivityBloc.connectivityStatusCode,
        builder: (context, AsyncSnapshot connectivitySnapshot) {
          return StreamBuilder(
              stream: musicDetailsbloc.musicDetails,
              builder:
                  (context, AsyncSnapshot<MusicDetailsModel> detailSnapshot) {
                return StreamBuilder(
                  stream: musicDetailsbloc.musicLyrics,
                  builder: (context, AsyncSnapshot<LyricsModel> lyricSnapshot) {
                    if (detailSnapshot.hasData && lyricSnapshot.hasData) {
                      return musicDetailsUI(
                          detailSnapshot: detailSnapshot,
                          lyricSnapshot: lyricSnapshot,
                          connectivitySnapshot: connectivitySnapshot,
                          ctx: context);
                    } else if (detailSnapshot.hasError ||
                        lyricSnapshot.hasError) {
                      return Text(detailSnapshot.error.toString());
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              });
        },
      ),
    );
  }

  Widget musicDetailsUI(
      {AsyncSnapshot<MusicDetailsModel> detailSnapshot,
      AsyncSnapshot<LyricsModel> lyricSnapshot,
      AsyncSnapshot connectivitySnapshot,
      ctx}) {
    List headings = ["Name", "Artist", "Album Name", "Explicit", "Lyrics"];
    List data = [
      detailSnapshot.data.message.body.track.trackName,
      detailSnapshot.data.message.body.track.artistName,
      detailSnapshot.data.message.body.track.albumName,
      detailSnapshot.data.message.body.track.explicit.toString(),
      lyricSnapshot.data.message.body.lyrics.lyricsBody,
    ];
    return connectivitySnapshot.data == 2
        ? Center(
            child: Text("No Internet Connection"),
          )
        : ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext ctx, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      headings[index],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9BAEF0)),
                    ),
                    Text(
                      data[index],
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
              );
            },
          );
  }
}
