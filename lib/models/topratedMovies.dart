import 'package:movieflix/models/movieitem.dart';

class TopratedMovies {
  TopratedMovies({
    this.results,
  });
  List<MovieItem>? results = [];

  TopratedMovies.fromJson(var json) {
    results =
        List.from(json['results']).map((e) => MovieItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['results'] = results!.map((e) => e.toJson()).toList();
    return _data;
  }
}
