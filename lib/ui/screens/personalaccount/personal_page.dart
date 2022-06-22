// @dart=2.9
import 'dart:io';
import 'package:covid_infected_helper/core/business_logic/profile_provider.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../core/model/vaccine_user.dart';
import '../../../core/utilities/api_service.dart';
import '../../helper/app_validator.dart';
import '../../widgets/app_padding.dart';
import '../../widgets/form_fields/app_input_text_field.dart';
import '../../widgets/form_fields/app_password_input_field.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({Key key, this.user}) : super(key: key);
  final VaccineUser user;

  @override
  Widget build(BuildContext context) {
    print(user.fullName);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bg,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(decoration: bgGradient),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: bg,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Personal Account',
          style: appbartextStyle,
        ),
      ),
      body: PersonalScreen(
        user: user,
      ),
    );
  }
}

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key key, this.user}) : super(key: key);
  final VaccineUser user;

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  final TextEditingController _nameContoller = TextEditingController();
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _phoneContoller = TextEditingController();
  bool isFile = false;
  String _image;

  @override
  void initState() {
    _image = widget.user.photoUrl;
    _nameContoller.text = widget.user.fullName;
    _emailContoller.text = widget.user.email;

    if (widget.user.phone != "") {
      _phoneContoller.text = widget.user.phone;
    }

    super.initState();
  }

  // void initialState() {

  // final ImagePicker _picker = ImagePicker();
  //
  // Future getImageGallery() async {
  //   final XFile photo = await _picker.pickImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     _image = photo.path;
  //
  //     isFile = true;
  //   });
  // }
  var picker = ImagePicker();
  String userImagePath;
  File userImagePathFile;

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      isFile = true;
      userImagePath = pickedFile.path;
      print(pickedFile.path);
      setState(() {});
      userImagePathFile = File(userImagePath);
      print(userImagePath);
    } else {
      print("No image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          decoration: const BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
          ),
        ),
        //for the image
        // free,
        _buildImage(),
        free,
        _buildKeyAndValue(
          key: const Text(
            'Full Name:',
            style: titleStyle,
          ),
          value: AppPadding(
            child: AppTextInputField(
              controller: _nameContoller,
              validator: (value) {
                return AppValidator.validatorRequired(value, context);
              },
              hintText: "Name",
            ),
          ),
        ),
        _buildKeyAndValue(
          key: const Text(
            'Email Account:',
            style: titleStyle,
          ),
          value: AppPadding(
            child: AppTextInputField(
              controller: _emailContoller,
              validator: (value) {
                return AppValidator.validatorEmail(value, context);
              },
              prefix: const AppPadding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(
                  FontAwesomeIcons.envelope,
                  color: mainColor,
                  size: 20,
                ),
              ),
              hintText: "Email",
            ),
          ),
        ),
        // if (widget.user.phone != "")
        _buildKeyAndValue(
          key: const Text(
            'Phone:',
            style: titleStyle,
          ),
          value: AppPadding(
            child: AppTextInputField(
              controller: _phoneContoller,
              validator: (value) {
                return AppValidator.validatorRequired(value, context);
              },
              prefix: const AppPadding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(
                  FontAwesomeIcons.phone,
                  color: mainColor,
                  size: 20,
                ),
              ),
              hintText: "phone",
            ),
          ),
        ),
        Center(
          child: _buildUpdateButton(),
        )
        // if (widget.user.password != "")
        //   _buildKeyAndValue(
        //     key: const Text(
        //       'Password:',
        //       style: titleStyle,
        //     ),
        //     value: AppPadding(
        //       child: AppPasswordInputField(
        //           controller: _passwordContoller,
        //           hintText: "Password",
        //           validator: (value) {
        //             return AppValidator.validatorPassword(value, context);
        //           }),
        //     ),
        //   ),

        // body of personal info
        // Expanded(
        //   child: Row(
        //     // mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [

        //           // const Text(
        //           //   'User id:',
        //           //   style: titleStyle,
        //           // ),
        //           // const SizedBox(
        //           //   height: 6,
        //           // ),
        //           // SizedBox(
        //           //   width: 240,
        //           //   height: 30,
        //           //   child: TextFormField(
        //           //     textAlign: TextAlign.start,
        //           //     textAlignVertical: TextAlignVertical.bottom,
        //           //     decoration: const InputDecoration(
        //           //       hintText: ' ',
        //           //       border: OutlineInputBorder(),
        //           //     ),
        //           //   ),
        //           // ),
        //           free,
        //           const Text(
        //             'Full Name:',
        //             style: titleStyle,
        //           ),
        //           const SizedBox(
        //             height: 6,
        //           ),

        //           // TextFormField(
        //           //   controller: _nameContoller,
        //           //   textAlign: TextAlign.start,
        //           //   textAlignVertical: TextAlignVertical.bottom,
        //           //   decoration: const InputDecoration(
        //           //     hintText: ' Marim Mohamed ', //--getter--from db
        //           //     border: OutlineInputBorder(),
        //           //   ),
        //           // ),
        //           free,
        //           const Text(
        //             'Email Account:',
        //             style: titleStyle,
        //           ),
        //           const SizedBox(
        //             height: 6,
        //           ),
        //           // TextFormField(
        //           //   controller: _emailContoller,
        //           //   textAlign: TextAlign.start,
        //           //   textAlignVertical: TextAlignVertical.bottom,
        //           //   decoration: const InputDecoration(
        //           //     hintText:
        //           //         ' Marim Mohamed@gmail.com ', //--getter--from db
        //           //     border: OutlineInputBorder(),
        //           //   ),
        //           // ),
        //           free,
        //           // if (widget.user.phone != null)
        //           //   const Text(
        //           //     'Phone Number:',
        //           //     style: titleStyle,
        //           //   ),
        //           // const SizedBox(
        //           //   height: 6,
        //           // ),
        //           /*if (widget.user.phone != "")
        //             SizedBox(
        //               width: 240,
        //               height: 80,
        //               child: TextFormField(
        //                 controller: _phoneContoller,
        //                 textAlign: TextAlign.start,
        //                 textAlignVertical:
        //                     TextAlignVertical.bottom,
        //                 decoration: const InputDecoration(
        //                   hintText:
        //                       ' Enter your phone number....', //--setter--from db
        //                   border: OutlineInputBorder(),
        //                 ),
        //               ),
        //             ),*/
        //           const SizedBox(
        //             height: 20,
        //           ),
        //           // if (widget.user.password != "")
        //           //   const Text(
        //           //     'Password:',
        //           //     style: titleStyle,
        //           //   ),
        //           // const SizedBox(
        //           //   height: 6,
        //           // ),
        //           // if (widget.user.password != "")
        //           //   SizedBox(
        //           //     width: 240,
        //           //     height: 70,
        //           //     child: TextFormField(
        //           //       controller: _passwordContoller,
        //           //       obscureText: true,
        //           //       textAlign: TextAlign.start,
        //           //       textAlignVertical:
        //           //           TextAlignVertical.bottom,
        //           //       decoration: const InputDecoration(
        //           //         // hintText:
        //           //         //     ' 26njwefhuenf ', //--getter--from db
        //           //         border: OutlineInputBorder(),
        //           //       ),
        //           //     ),
        //           //   ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        //button of saving any edit in personal information
      ],
    );
  }

  _buildKeyAndValue({Widget key, Widget value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20), child: key),
        // const SizedBox(
        //   height: 4,
        // ),
        value
      ],
    );
  }

  _buildUpdateButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 250, 0),
      child: GestureDetector(
        onTap: () {
          userImagePath != null
              ? Provider.of<ProfileProvider>(context, listen: false)
                  .uploadProfileImage(
                  imagePath: userImagePath,
                  userProfileImage: userImagePathFile,
                  context: context,
                  fullName: _nameContoller.text,
                  phone: _phoneContoller.text,
                )
              : Provider.of<ProfileProvider>(context, listen: false)
                  .updateUserData(
                  context: context,
                  name: _nameContoller.text,
                  phone: _phoneContoller.text,
                  image: _image,
                );
        },
        child: Container(
          alignment: Alignment.center,
          width: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: mainColor,
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Save',
              style: TextStyle(
                  color: bg, fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  _buildImage() {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Center(
        child: Stack(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: bg,
              child: ClipOval(
                child: userImagePath == null
                    ? const Text('not loaded', style: subtxtStyle)
                    : !isFile
                        ? Image.network(_image, fit: BoxFit.cover, width: 110)
                        : Image.file(userImagePathFile, width: 110),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 12),
                  FloatingActionButton(
                    onPressed: getProfileImage,
                    mini: true,
                    backgroundColor: mainColor,
                    elevation: 0,
                    tooltip: 'upload from gallery',
                    child: const Icon(
                      Icons.add_a_photo_rounded,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
