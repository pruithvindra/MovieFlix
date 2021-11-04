import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/models/nowPlaying.dart';
import 'package:movieflix/providers/repo.dart';
import 'package:movieflix/screens/descriptionscreen.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    Key? key,
    required this.width,
    required this.Movie,
  }) : super(key: key);

  final double width;
  final Movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, DescriptionScreen.routename,
                arguments: Movie);
          },
          child: Stack(
            children: [
              Container(
                height: 200,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    CachedNetworkImage(
                        width: width * 0.3,
                        imageUrl: poster_path(Movie.posterPath)),
                    SizedBox(
                      width: 0,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Movie.title,
                                style: Style.display3.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 25)),
                            AutoSizeText(
                              Movie.overview,
                              style: Style.display2,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 20,
                              minFontSize: 15,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 5,
                  right: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(5),
                    child: IconButton(
                        onPressed: () {
                          Provider.of<DataProvider>(context, listen: false)
                              .removedata(Movie);

                          // Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        )),
                  )),
            ],
          ),
        ),
        Divider(
          color: Colors.white,
          thickness: 1,
        )
      ],
    );
  }
}
