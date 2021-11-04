import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/components/formWidget.dart';
import 'package:movieflix/components/themebutton.dart';
import 'package:movieflix/providers/repo.dart';
import 'package:movieflix/style.dart';
import 'package:movieflix/widgets/movietile.dart';
import 'package:provider/provider.dart';

class TopRatedScreen extends StatefulWidget {
  TopRatedScreen({Key? key}) : super(key: key);

  @override
  _NowplayingScreenState createState() => _NowplayingScreenState();
}

class _NowplayingScreenState extends State<TopRatedScreen> {
  @override
  bool istap = false;
  var repository;
  void initState() {
    repository = Provider.of<DataProvider>(context, listen: false);
    // TODO: implement initState
  }

  void ontap() {
    setState(() {
      istap = true;
    });
  }

  var searchmovies = [];

  searchf(value) {
    searchmovies = [];
    searchval = value;

    var movies = repository.topratedMovies.results;

    movies!.forEach((element) {
      element.title.toLowerCase().contains(searchval)
          ? searchmovies.add(element)
          : null;
    });
    print('the len is ${searchmovies.length}');
    print(searchval);
    setState(() {});
  }

  var searchval = null;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return RefreshIndicator(
      onRefresh: () async {
        return repository.getdata();
      },
      child: Container(
        height: height,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: FormWIdget(
                    hintText: 'search',
                    sufixicon: Icon(Icons.search),
                    width: width * 0.4,
                    onTap: ontap,
                    onchanged: (val) {
                      searchf(val);
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ChangeThemeButtonWidget(),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                // physics: BouncingScrollPhysics(),
                child: Consumer<DataProvider>(
                  builder: (ctx, data, _) {
                    List movies = data.topratedMovies.results as List;

                    return data.topratedMovies.results!.length == 0 ||
                            data.topratedMovies.results!.length == null
                        ? Column(
                            children: [
                              Text("No Data to show",
                                  style: Style.display3.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              Container(
                                height: height,
                              )
                            ],
                          )
                        : searchval == '' || searchval == null
                            ? Column(
                                children: List.generate(
                                    data.topratedMovies.results!.length,
                                    (index) {
                                  return MovieTile(
                                    width: width,
                                    Movie: data.topratedMovies.results![index],
                                  );
                                }),
                              )
                            : Column(
                                children:
                                    List.generate(searchmovies.length, (index) {
                                  return MovieTile(
                                    width: width,
                                    Movie: searchmovies[index],
                                  );
                                }),
                              );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
