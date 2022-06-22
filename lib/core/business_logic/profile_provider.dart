import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_infected_helper/core/business_logic/auth_provider.dart';
import 'package:covid_infected_helper/core/model/vaccine_user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';


class ProfileProvider with ChangeNotifier {
  // static File? pickedImage;
  File? userImage;
  VaccineUser? userModel;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      userImage = File(pickedFile.path);
      print(userImage);
      notifyListeners();
    } else {
      print("No image selected");
      notifyListeners();
    }
  }

  void uploadProfileImage({
    required BuildContext context,
    String? fullName,
    String ?phone,
    String ? imagePath,
    File ?userProfileImage,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(imagePath!)
        .pathSegments
        .last}')
        .putFile(userProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(context: context,
            name: fullName,
            phone: phone,
            image: value);
        notifyListeners();
      }).catchError((error) {
        print(error);
        notifyListeners();
      });
    }).catchError((error) {
      print(error);
      notifyListeners();
    });
  }

  void updateUserData({
    required BuildContext context,
    String ?name,
    String ?phone,
    String ?image,
  }) {
    VaccineUser userModel = VaccineUser(
      email: Provider
          .of<AuthProvider>(context, listen: false)
          .currentUser!
          .email,
      fullName: name,
      phone: phone,
      uid: Provider
          .of<AuthProvider>(context, listen: false)
          .currentUser!
          .uid,

      photoUrl: image,
      status: Provider
          .of<AuthProvider>(context, listen: false)
          .currentUser!
          .status,
      lat: Provider
          .of<AuthProvider>(context, listen: false)
          .currentUser!
          .lat,
      lang: Provider
          .of<AuthProvider>(context, listen: false)
          .currentUser!
          .lang,
      resultAnswerQuestion: Provider
          .of<AuthProvider>(context, listen: false)
          .currentUser!
          .resultAnswerQuestion,
      dataOfVaccine: Provider
          .of<AuthProvider>(context, listen: false)
          .currentUser!
          .dataOfVaccine,
      password: Provider
          .of<AuthProvider>(context, listen: false)
          .currentUser!
          .password,

    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(Provider
        .of<AuthProvider>(context, listen: false)
        .currentUser!
        .uid)
        .update(userModel.toJson())
        .then((value) {
      getUser(context: context).then((value) => Navigator.of(context).pop());

      notifyListeners();
    })
        .catchError((error) {
      print(error.toString()+"jjjjjjjjjjjjjjjjjjj");
      notifyListeners();
    });
  }
  VaccineUser? userProfile;
 Future <void> getUser({required BuildContext context,String id=""}) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(id.isNotEmpty?id:Provider.of<AuthProvider>(context,listen: false).currentUserUId)
        .get()
        .then(
          (res) {
        userProfile = VaccineUser.fromJson(res.data()!);
          Provider.of<AuthProvider>(context, listen: false).saveUser(userProfile);
          notifyListeners();
      },
      onError: (e) => print("Error completing: $e"),
    );
    // setState(() {});
  }




}
