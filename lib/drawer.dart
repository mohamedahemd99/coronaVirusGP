// @dart=2.9
import 'dart:io';

import 'package:covid_infected_helper/constants.dart';
import 'package:covid_infected_helper/ui/screens/notifications/time_vacine.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'core/business_logic/auth_provider.dart';
import 'core/model/vaccine_user.dart';
import 'ui/screens/authentication/login_screen.dart';
import 'ui/screens/info.dart';
import 'ui/screens/Home/home.dart';
import 'ui/screens/Home/updates.dart';
import 'ui/screens/articles/aticles_page.dart';
import 'ui/screens/personalaccount/personal_page.dart';
import 'ui/screens/quests/questions.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key key, this.user}) : super(key: key);
  final VaccineUser user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              user?.fullName ?? "",
            ),
            accountEmail: Text(
              user?.email,
            ),
            currentAccountPicture: user.photoUrl != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                    user.photoUrl,
                  ))
                : null,
            decoration: const BoxDecoration(
              color: mainColor,
              image: DecorationImage(
                image: AssetImage('images/covid-19.jpg'),
                opacity: 50,
                fit: BoxFit.fill,
              ),
            ),
          ),
          // ListTile(
          //     leading: const Icon(
          //       Icons.home,
          //       color: mainColor,
          //     ),
          //     title: const Text(
          //       'Home Page',
          //       style: titleStyle,
          //     ),
          //     onTap: () {
          //       Navigator.pop(context); //close drawer
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => HomeScreen(
          //               isAppbar: true,
          //             ),
          //           ));

          //       // Navigator.pop(context);
          //     }),
          // const Divider(
          //   color: icons,
          // ),
          ListTile(
            leading: const Icon(
              Icons.account_circle,
              color: mainColor,
            ),
            title: const Text(
              'Personal Account',
              style: titleStyle,
            ),
            onTap: () {
              Navigator.pop(context); //close drawer
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PersonalPage(
                            user: user,
                          )));
            },
          ),
          ListTile(
              leading: const Icon(
                Icons.info_rounded,
                color: mainColor,
              ),
              title: const Text(
                'Updates',
                style: titleStyle,
              ),
              onTap: () {
                Navigator.pop(context); //close drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Updates(),
                    ));
              }),
          ListTile(
              leading: const Icon(
                Icons.info_outline_rounded,
                color: mainColor,
              ),
              title: const Text(
                'Infected Symptoms',
                style: titleStyle,
              ),
              onTap: () {
                Navigator.pop(context); //close drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InfoPage(),
                    ));
              }),
          ListTile(
            leading: const Icon(
              Icons.article,
              color: mainColor,
            ),
            title: const Text(
              'Articles',
              style: titleStyle,
            ),
            onTap: () {
              Navigator.pop(context); //close drawer
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ArticlePage()));
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.stethoscope,
              color: mainColor,
            ),
            title: const Text(
              'Examiner',
              style: titleStyle,
            ),
            onTap: () {
              Navigator.pop(context); //close drawer
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Questions(
                            user: user,
                          )));
            },
          ),
          const Divider(
            color: icons,
          ),
          ListTile(
              leading: const Icon(
                Icons.schedule,
                color: mainColor,
              ),
              title: const Text(
                'Select Vaccine time',
                style: titleStyle,
              ),
              onTap: () {
                Navigator.pop(context); //close drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TimeVacineScreen(
                              user: user,
                            )));
                //close drawer
              }),
          ListTile(
              leading: const Icon(
                Icons.description,
                color: mainColor,
              ),
              title: const Text(
                'Politicies',
                style: titleStyle,
              ),
              onTap: () {
                Navigator.pop(context); //close drawer
              }),
          ListTile(
              leading: const Icon(
                Icons.share,
                color: mainColor,
              ),
              title: const Text(
                'Share us',
                style: titleStyle,
              ),
              onTap: () {}),
          const Divider(
            color: icons,
          ),
          ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: mainColor,
              ),
              title: const Text(
                'Exit',
                style: titleStyle,
              ),
              onTap: () {
                // Navigator.of(context, rootNavigator: true).pop();
                Provider.of<AuthProvider>(context, listen: false)
                    .logout(context: context);
              }),
        ],
      ),
    );
  }
}
