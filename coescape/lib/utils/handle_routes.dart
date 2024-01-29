import 'package:flutter/material.dart';

import '../models/user.dart';
import '../views/home.dart';

enum ViewType {
  // Add your view types here
  home
}

Map<String, WidgetBuilder> generateRoutes() {
  return {
    // Add your routes here
    '/home': (context) => buildView(context, ViewType.home),
  };
}

Widget buildView(BuildContext context, ViewType viewType) {
  var args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  //var databaseService = args['databaseService'] as DatabaseService;
  //var authService = args['authService'] as AuthService;
  var user = args['user'] as AppUser;

  switch (viewType) {
    // Add your view types here
    case ViewType.home:
      return Home(user: user);
    default:
      return Container();
  }
}
