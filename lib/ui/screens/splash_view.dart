// ignore: import_of_legacy_library_into_null_safe

import 'package:covid_infected_helper/core/business_logic/auth_provider.dart';
import 'package:covid_infected_helper/core/model/vaccine_user.dart';
import 'package:covid_infected_helper/core/utilities/app_local_storage.dart';
import 'package:covid_infected_helper/ui/screenat/screenat/onboardingscreen/onboarding_view.dart';
import 'package:covid_infected_helper/ui/screens/layout/layout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/business_logic/profile_provider.dart';
import '../resources/app_palette.dart';
import 'authentication/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      get(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppPalette.primaryColor, body: _buildScreen());
  }

  Widget _buildScreen() {
    return Center(
      child: Image.asset(
        'images/orange.png',
        fit: BoxFit.cover,
      ),
    );
  }

  // ignore: non_constant_identifier_names

  void get(BuildContext ctx) async {
    bool? onBoarding = await AppLocalStorage.getBool("onBoarding") ?? false;
    print(onBoarding);
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null && !onBoarding) {
        // print('User is currently signed out!');
        Navigator.pushReplacement(
            ctx, MaterialPageRoute(builder: (ctx) => const OnBoardingView()));
      } else if (user == null) {
        Navigator.pushReplacement(
            ctx, MaterialPageRoute(builder: (ctx) => const Login()));
      } else {
        Provider.of<ProfileProvider>(context,listen: false).getUser(context: context,id: user.uid);

        Provider.of<AuthProvider>(context, listen: false).saveUid(user.uid);
        print(Provider.of<AuthProvider>(context, listen: false).currentUserUId);
        print(user.uid);
        Provider.of<AuthProvider>(context, listen: false).saveUser(
          VaccineUser(
              fullName: user.displayName,
              email: user.email,
              photoUrl: user.photoURL,
              uid: user.uid),
        );
        // print(Provider.of<AuthProvider>(context,listen: false).currentUserUId);
        Navigator.pushReplacement(
          ctx,
          MaterialPageRoute(
            builder: (ctx) => LayOutScreen(
              user: VaccineUser(
                  fullName: user.displayName,
                  email: user.email,
                  photoUrl: user.photoURL,
                  uid: user.uid),
            ),
          ),
        );
      }
    });
  }
}
