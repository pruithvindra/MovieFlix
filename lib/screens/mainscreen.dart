import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/components/formWidget.dart';
import 'package:movieflix/components/themebutton.dart';
import 'package:movieflix/providers/repo.dart';
import 'package:movieflix/providers/themeprovider.dart';
import 'package:movieflix/screens/nowplayingScreen.dart';
import 'package:movieflix/screens/topratedscreen.dart';
import 'package:movieflix/style.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _NowplayingScreenState createState() => _NowplayingScreenState();
}

class _NowplayingScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  late PageController _pageController;
  // bool istap = false;
  bool isloading = false;
  List<Widget> tabPages = [NowplayingScreen(), TopRatedScreen()];

  @override
  void initState() {
    super.initState();
    fetchdata();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  fetchdata() async {
    setState(() {
      isloading = true;
    });

    try {
      await Provider.of<DataProvider>(context, listen: false).getdata();
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      setState(() {
        isloading = false;
      });
      // TODO
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.movie_filter_sharp), label: 'Now Playing'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Top Rated'),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: PageView(
            children: tabPages,
            onPageChanged: onPageChanged,
            controller: _pageController,
          ),
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
