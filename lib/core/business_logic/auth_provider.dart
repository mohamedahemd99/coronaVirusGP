import 'package:covid_infected_helper/core/model/vaccine_user.dart';
import 'package:covid_infected_helper/core/utilities/api_service.dart';
import 'package:covid_infected_helper/ui/screens/layout/layout_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../ui/screens/authentication/login_screen.dart';


class AuthProvider with ChangeNotifier {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String ?currentUserUId;
  VaccineUser ?currentUser;
  void saveUid(String ?uid){
    currentUserUId=uid;
    notifyListeners();
  }
  void saveUser(VaccineUser ?user){
    currentUser=user;
    notifyListeners();
  }
  //create  user with email and password//
  void defaultRegister(
      {required String email,
      required String password,
      required context}) async {
    await Auth().createUser(email, password).then((value) {
      currentUserUId=value.uid;
      print(value.email);
      addUser(user: value, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));

      notifyListeners();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
      print(error);
      notifyListeners();
    });
  }

//login with email and password//
  void defaultLogin(
      {required String email,
      required String password,
      required context}) async {
    await Auth().signIn(email, password).then((value) {
      print(value.uid);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LayOutScreen(
                    user: VaccineUser(
                        fullName: value.displayName,
                        email: value.email,
                        photoUrl: value.photoURL,
                        uid: value.uid),
                  )));

      notifyListeners();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
      print(error);
      notifyListeners();
    });
  }

  void loginWithFacebook({required context}) async {
    await Auth().signInWithFacebook().then((value) {
      addUser(user: value);
      print(value.displayName);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LayOutScreen(
                    user: VaccineUser(
                        fullName: value.displayName,
                        email: value.email,
                        photoUrl: value.photoURL,
                        uid: value.uid),
                  )));
      notifyListeners();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
      print(error);
      notifyListeners();
    });
  }

  void loginWithGoogle({required context}) async {
    Auth().signInWithGoogle().then((value) {
      print(value.refreshToken);
      addUser(user: value);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LayOutScreen(
                    user: VaccineUser(
                        fullName: value.displayName,
                        email: value.email,
                        photoUrl: value.photoURL,
                        uid: value.uid),
                  )));
      notifyListeners();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
      print(error);
      notifyListeners();
    });
  }

  void logout({required context}) async {
    await Auth().signOut().then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
          (Route<dynamic> route) => false);
      notifyListeners();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
      print(error);
      notifyListeners();
    });
  }

  void ResetByEmail(String email, context) async {
    await Auth().sendPasswordResetEmail(email).then((value) {
      // AppDialogs.showSnakBar(context, "Check your Email");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
          (Route<dynamic> route) => false);
      notifyListeners();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
      print(error);
      notifyListeners();
    });
  }

//addUser//
  Future<void> addUser(
      {User? user,
      String? password,
      double? lat,
      double? lang,
      int? answerOfQuestion,
      String? status,
      String? dateOfVaccine}) {
    // Call the user's CollectionReference to add a new user

    return users.doc(user!.uid).set(
      {
        'fullName': user.displayName,
        "email": user.email,
        "photoUrl": user.photoURL,
        "phone": user.phoneNumber ?? "",
        "password": password ?? "",
        "lat": lat ?? "",
        "lang": lang ?? "",
        "resultAnswerQuestion": answerOfQuestion ?? 0,
        "status": status ?? "",
        "dataOfVaccine": dateOfVaccine ?? "",
        "uid": user.uid
      },
      //mergevalue  SetOptions(merge: true),
    ).then((value) {
      if (kDebugMode) {
        print("User Added");
      }
      notifyListeners();
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUser(VaccineUser vaccineUser) {
    return users
        .doc(vaccineUser.uid)
        .update(vaccineUser.toJson())
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
