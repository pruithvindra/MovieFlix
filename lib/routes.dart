import 'package:flutter/widgets.dart';
import 'package:movieflix/screens/descriptionscreen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  DescriptionScreen.routename: (ctx) => DescriptionScreen(),
  // Mainscreen.routename: (ctx) => Mainscreen(),
};
