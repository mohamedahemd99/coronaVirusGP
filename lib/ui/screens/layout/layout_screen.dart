import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_infected_helper/core/business_logic/auth_provider.dart';

import 'package:covid_infected_helper/ui/screens/quests/questions.dart';

import '../../../core/model/vaccine_user.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../core/business_logic/layout_provider.dart';
import '../../../../drawer.dart';
import '../notifications/app_notification.dart';

class LayOutScreen extends StatefulWidget {
  LayOutScreen({Key? key, this.user}) : super(key: key);
  final VaccineUser? user;

  @override
  State<LayOutScreen> createState() => _LayOutScreenState();
}

class _LayOutScreenState extends State<LayOutScreen> {
  VaccineUser? userProfile;
  void getUser() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(Provider.of<AuthProvider>(context, listen: false).currentUserUId)
        .get()
        .then(
      (res) {
        userProfile = VaccineUser.fromJson(res.data()!);
        setState(() {});
      },
      onError: (e) => print("Error completing: $e"),
    );
    // setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<LayOutProvider>(context,listen: false).getAllMasksType();
    getUser();
    AppNotification.onSelectNotify.stream.listen(SelectPage);
    super.initState();
  }

  void SelectPage(String? event) {
    print(event);
    if (event != "hello") {
      VaccineUser user = VaccineUser.fromJson(jsonDecode(event!));
      print(user.email);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Questions(
                    user: user,
                  )));
    }
    //  else {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => L()),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LayOutProvider>(context);
    return userProfile != null
        ? Scaffold(
            drawer: NavBar(
              user: userProfile,
            ),
            appBar: AppBar(
              elevation: 0,
              flexibleSpace: Container(decoration: bgGradient),
              title: image,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings, color: bg),
                  onPressed: () {},
                ),
              ],
            ),
            body: DoubleBackToCloseApp(
              child: provider.screens[provider.currentIndex],
              snackBar: const SnackBar(
                content: Text('Tap back again to leave'),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0.0,
              currentIndex: provider.currentIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.red,
              onTap: (index) {
                provider.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color:
                          provider.currentIndex == 0 ? Colors.red : Colors.grey,
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.newspaper_outlined,
                      color:
                          provider.currentIndex == 1 ? Colors.red : Colors.grey,
                    ),
                    label: "News"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.bar_chart,
                      color:
                          provider.currentIndex == 2 ? Colors.red : Colors.grey,
                    ),
                    label: "Chart"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.location_on_outlined,
                      color:
                          provider.currentIndex == 3 ? Colors.red : Colors.grey,
                    ),
                    label: "Maps"),
              ],
            ),
          )
        : const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
  }
}
