import 'package:chat_app/ui/widgets/pages/EditProfile.dart';
import 'package:chat_app/ui/widgets/pages/HomePage.dart';
import 'package:chat_app/ui/widgets/pages/SplachScreen.dart';
import 'package:chat_app/ui/auth/providers/ChatProvider.dart';
import 'package:chat_app/ui/auth/providers/auth_provider.dart';
import 'package:chat_app/ui/auth/providers/route_helper.dart';
import 'package:chat_app/ui/widgets/pages/AuthMainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
      ),
      ChangeNotifierProvider<ChatProvider>(create: (context) => ChatProvider())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: RouteHelper.routeHelper.navigationKey,
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget),
        maxWidth: 1200,
        minWidth: 400,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(400, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      routes: {
        HomePage.routeName: (context) => HomePage(),
        AuthMainPage.routeName: (context) => AuthMainPage(),
        SplachScreen.routeName: (context) => SplachScreen(),
        EditProfile.routeName: (context) => EditProfile()
      },
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  AuthProvider authProvider = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return SplachScreen();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
