// @dart=2.9
import 'package:covid_infected_helper/core/business_logic/map_provider.dart';
import 'package:covid_infected_helper/core/business_logic/profile_provider.dart';
import 'package:covid_infected_helper/ui/screens/notifications/app_notification.dart';
import 'package:covid_infected_helper/ui/screens/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'core/business_logic/auth_provider.dart';
import 'core/business_logic/layout_provider.dart';
import 'core/business_logic/news_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppNotification.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();

//  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(
    const InitialRoute(),
  );
}

//material
class InitialRoute extends StatelessWidget {
  const InitialRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LayOutProvider()..getAllMasksType(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(
            create: (context) => MapProvider()..getAllUsers()..determinePosition, lazy: false),
        ChangeNotifierProvider(
            create: (context) => NewsProvider()
              ..getHealth()
              ..getSummaryCoronaVirus(),
            lazy: false),
      ],
      child: MaterialApp(
        color: mainColor,
        debugShowCheckedModeBanner: false,
        title: "Covid Infected Helper",
        home: SplashScreen(),
        theme: getThemes(),
      ),
    );
  }
}
