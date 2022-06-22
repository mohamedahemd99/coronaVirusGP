// @dart=2.9
import 'package:covid_infected_helper/constants.dart';
import 'package:covid_infected_helper/core/business_logic/auth_provider.dart';
import 'package:covid_infected_helper/ui/helper/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/utilities/api_service.dart';
import '../../widgets/app_padding.dart';
import '../../widgets/form_fields/app_input_text_field.dart';
import '../../widgets/form_fields/app_password_input_field.dart';
import 'login_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passVisible = false;
  bool _confirmPasswordVisible = false;

  final _confirmPassword = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  String validatePassword(String value) {
    if (!(value.length > 8) && value.isNotEmpty) {
      return "Password should contain more than 8 characters.";
    } else {
      return null;
    }
  }

  void click() async {
    Auth auth = Auth();
    await auth.signInWithGoogle();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: bg,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: mainColor.withOpacity(0.14),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: bg,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Back',
          style: TextStyle(
            color: bg,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          //to make the design of this page exactly princible for any size devices
          width: double.infinity,
          decoration: bgGradient,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.person_pin,
                  size: 88,
                  color: mainColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppPadding(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 54),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 1.4,
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
                          //the header
                          const Text(
                            "Create Account",
                            style: headerStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //subtexts
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Text(
                              "Enter Your Email,and Password to sign up.",
                              textAlign: TextAlign.left,
                              style: subtxtStyle,
                            ),
                          ),
                          //link of -have an account?-
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  //click function in this to view the helper page in datalogin which forgotten
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Login(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "have an account?",
                                    style: TextStyle(color: links),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //field of full name
                          const SizedBox(
                            height: 10,
                          ),
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

                          // const SizedBox(
                          //   height: 7,
                          // ),
                          //field of PAssword
                          AppPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: AppPasswordInputField(
                                controller: _passwordController,
                                hintText: "Password",
                                validator: (value) {
                                  return AppValidator.validatorPassword(
                                      value, context);
                                }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: AppPasswordInputField(
                                controller: _confirmPassword,
                                hintText: "Confirm password",
                                validator: (value) {
                                  if (_passwordController.text !=
                                      _confirmPassword.text) {
                                    return "password is not match the first one";
                                  } else {
                                    return AppValidator.validatorPassword(
                                        value, context);
                                  }
                                }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          //button to go to login page
                          RaisedButton(
                            color: mainColor,
                            onPressed: () {
                              {
                                if (_formKey.currentState.validate()) {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .defaultRegister(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          context: context);
                                }
                              }
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: bg,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          //texts of privacy policy
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "By signning up you agree to our terms conditions & privacy policy.",
                              style: subtxtStyle,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //the line design
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 0.7,
                                width: 120,
                                child: Container(
                                  color: textLightColor,
                                ),
                              ),
                              const SizedBox(
                                width: 2.0,
                              ),
                              const Text(
                                "Or",
                                style: subtxtStyle,
                              ),
                              SizedBox(
                                height: 0.7,
                                width: 120,
                                child: Container(
                                  color: textLightColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //signning by facebook or google
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .loginWithFacebook(context: context);
                                  },
                                  icon: const Icon(FontAwesomeIcons.facebook,
                                      color: Colors.blue)),
                              IconButton(
                                onPressed: () {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .loginWithGoogle(context: context);
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.redAccent,
                                ),
                              ),
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
        ),
      ),
    );
  }
}
