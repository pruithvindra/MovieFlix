import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movieflix/models/movieitem.dart';
import 'package:movieflix/models/nowPlaying.dart';
import 'package:movieflix/style.dart';

class DescriptionScreen extends StatefulWidget {
  DescriptionScreen({Key? key}) : super(key: key);

  static const routename = 'desc';

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    MovieItem Movie = ModalRoute.of(context)!.settings.arguments as MovieItem;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                height: height,
                width: width,
                child: CachedNetworkImage(
                  imageUrl: poster_path(
                    Movie.posterPath,
                  ),
                  fit: BoxFit.cover,
                )),
            Positioned(
                left: 5,
                top: 5,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(5),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded)),
                )),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Card(
                color: Colors.grey.withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(Movie.title,
                          style: Style.display3.copyWith(fontSize: 28)),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star_outlined),
                              Text(Movie.popularity.toString(),
                                  style: Style.display2.copyWith(fontSize: 20)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.date_range),
                              Text(Movie.releaseDate.toString(),
                                  style: Style.display2.copyWith(fontSize: 20)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.people),
                              Text(Movie.voteCount.toString(),
                                  style: Style.display2.copyWith(fontSize: 20)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(Movie.overview,
                          style: Style.display3.copyWith(fontSize: 28)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
