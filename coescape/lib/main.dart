import 'package:coescape/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user_handler.dart';
import 'responsive/responsive_layout.dart';
import 'services/auth.dart';
import 'utils/handle_routes.dart';
import 'views/wrappers/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserHandler?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (context, error) {
        return null;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Attendify",
        theme: ThemeData.light(),
        home: const ResponsiveLayout(mobileScreenLayout: Wrapper()),
        routes: generateRoutes(),
      ),
    );
  }
}
