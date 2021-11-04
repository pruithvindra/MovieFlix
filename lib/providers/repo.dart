import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movieflix/models/movieitem.dart';
import 'package:movieflix/models/nowPlaying.dart';
import 'package:movieflix/models/topratedMovies.dart';

class DataProvider with ChangeNotifier {
  var _nowplayingurl =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed';
  var _topratedurl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed';

  NowPlaying nowPlaying = NowPlaying(results: []);
  TopratedMovies topratedMovies = TopratedMovies();

  Future getdata() async {
    print('fetchiing');
    try {
      var nowPlayingresponse = await http.get(Uri.parse(_nowplayingurl));
      var topRatedresponse = await http.get(Uri.parse(_topratedurl));

      nowPlaying = NowPlaying.fromJson(jsonDecode(nowPlayingresponse.body));
      topratedMovies =
          TopratedMovies.fromJson(jsonDecode(topRatedresponse.body));

      print(topratedMovies.results![0].genreIds);

      print('Data Fetched');
    } on Exception catch (e) {
      throw e;

      // TODO
    }
    notifyListeners();
    // print(nowPlaying.results.length);
  }

  removedata(MovieItem Movie) {
    nowPlaying.results.removeWhere((element) => element.id == Movie.id);

    topratedMovies.results!.removeWhere((element) => element.id == Movie.id);

    notifyListeners();
  }
}
