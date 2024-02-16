import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'models/user_handler.dart';
import 'responsive/responsive_layout.dart';
import 'services/auth.dart';
import 'utils/handle_routes.dart';
import 'views/wrappers/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_flutterMessagingBackgroundHandler);
  runApp(
    const App(),
  );
}

Future<void> _flutterMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
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
