// @dart=2.9
// ignore_for_file: deprecated_member_use

import 'package:covid_infected_helper/ui/widgets/app_padding.dart';
import 'package:covid_infected_helper/ui/widgets/form_fields/app_password_input_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../core/business_logic/auth_provider.dart';
import '../../helper/app_validator.dart';
import '../../widgets/form_fields/app_input_text_field.dart';
import 'forget_password_screen.dart';
import 'signIn_screen.dart';

//login-Screen
class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passVisible;

  @override
  void initState() {
    _passVisible = _passVisible ?? false;
  }

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String validatePassword(String value) {
    if (!(value.length > 8) && value.isNotEmpty) {
      return "Password should contain more than 8 characters.";
    } else {
      return null;
    }
  }

  //empty function for preventing any errors.
  void click(String loginType) {
    if (loginType == "google") {
      Provider.of<AuthProvider>(context, listen: false)
          .loginWithGoogle(context: context);
    } else {
      Provider.of<AuthProvider>(context, listen: false)
          .loginWithFacebook(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    //to make the design of this page exactly princible for any size devices
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,

                    decoration: bgGradient,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 43,
                        ),
                        const SizedBox(
                          child: Icon(
                            Icons.person,
                            size: 120,
                            color: mainColor,
                          ),
                        ),
                        AppPadding(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 43),
                            width: double.infinity,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 1.5,
                            decoration: const BoxDecoration(
                              color: bg,
                              borderRadius: bodyCircular,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // the header -LOGIN-
                                  const Text(
                                    "Login Now!",
                                    style: headerStyle,
                                  ),
                                  //free space
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //the subText of the header
                                  const Text(
                                    "Please Login to Start With CIH..",
                                    style: subtxtStyle,
                                  ),
                                  //free space
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //the field of Email Address
                                  //field of Email Address
                                  AppPadding(
                                    child: AppTextInputField(
                                      controller: _emailController,
                                      validator: (value) {
                                        return AppValidator.validatorEmail(
                                            value, context);
                                      },
                                      prefix: const AppPadding(
                                        padding: EdgeInsets.only(bottom: 4),
                                        child: Icon(
                                          FontAwesomeIcons.envelope,
                                          color: mainColor,
                                          size: 20,
                                        ),
                                      ),
                                      hintText: "Email Address",
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 7,
                                  ),
                                  //field of PAssword
                                  AppPadding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: AppPasswordInputField(
                                        controller: _passwordController,
                                        hintText: "Password",
                                        validator: (value) {
                                          return AppValidator.validatorRequired(
                                              value, context);
                                        }),
                                  ),

                                  // const SizedBox(
                                  //   height: 4,
                                  // ),
                                  //for link -forget password- with padding from all direction
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(20, 0, 30, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          //click function in this to view the helper page in datalogin which forgotten
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                    const ForgetPassword()));
                                          },
                                          child: Text(
                                            "Forget Password",
                                            style: TextStyle(color: links),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  //the button to the home page
                                  AppPadding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: RaisedButton(
                                      color: mainColor,
                                      onPressed: () {
                                        {
                                          if (_formKey.currentState
                                              .validate()) {
                                            Provider.of<AuthProvider>(context,
                                                listen: false)
                                                .defaultLogin(
                                                email:
                                                _emailController.text,
                                                password:
                                                _passwordController
                                                    .text,
                                                context: context);
                                          }
                                        }
                                      },
                                      child: const Text(
                                        'Sign in',
                                        style: TextStyle(
                                            color: bg,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 17,
                                  ),
                                  //the row of -don't have an account- and it's link to sign up page
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Don`t have an account? ',
                                        style: subtxtStyle,
                                      ),
                                      TextButton(
                                        //click function in this to view the Sign up page
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const SignUp()));
                                        },
                                        child: Text(
                                          "Create new one!",
                                          style: TextStyle(color: links),
                                        ),
                                      )
                                    ],
                                  ),
                                  //free space
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  //another choise of logging
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 0.7,
                                        width: 100,
                                        child: Container(
                                          color: textLightColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 2.0,
                                      ),
                                      const Text("Or Login using ",
                                          style: subtxtStyle),
                                      SizedBox(
                                        height: 0.7,
                                        width: 100,
                                        child: Container(
                                          color: textLightColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  //free space
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  //logging by facebook or google
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          onPressed: () => click("facebook"),
                                          icon: const Icon(
                                              FontAwesomeIcons.facebook,
                                              color: Colors.blue)),
                                      IconButton(
                                          onPressed: () => click("google"),
                                          icon: const Icon(
                                            FontAwesomeIcons.google,
                                            color: Colors.redAccent,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
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
