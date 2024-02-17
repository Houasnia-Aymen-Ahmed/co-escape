import 'package:flutter/material.dart';

import '../models/user.dart';
import '../views/home/home.dart';
import '../views/wrappers/wrapper.dart';

enum ViewType {
  // Add your view types here
  home,
  wrapper,
}

Map<String, WidgetBuilder> generateRoutes() {
  return {
    // Add your routes here
    '/home': (context) => buildView(context, ViewType.home),
    '/wrapper': (context) => buildView(context, ViewType.wrapper),
  };
}

Widget buildView(BuildContext context, ViewType viewType) {
  var args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  var user = args['user'] as AppUser;

  switch (viewType) {
    // Add your view types here
    case ViewType.home:
      return Home(user: user);
    case ViewType.wrapper:
      return const Wrapper();
    default:
      return Container();
  }
}
