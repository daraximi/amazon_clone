import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_spacer.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        email: _emailController.text,
        context: context,
        password: _passwordController.text,
        name: _nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundCOlor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text("Create account",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _nameController,
                            hintText: "Name",
                          ),
                          const CustomSpacer(),
                          CustomTextField(
                            controller: _emailController,
                            hintText: "Email",
                          ),
                          const CustomSpacer(),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: "Password",
                          ),
                          const CustomSpacer(),
                          CustomButton(
                              buttonText: "Sign Up", onPressed: (){
                                if(_signUpFormKey.currentState!.validate()){
                                  signUpUser();
                                }
                              })
                        ],
                      )),
                ),
              ListTile(
                tileColor: (_auth == Auth.signin)
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text("Sign in account",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          const CustomSpacer(),
                          CustomTextField(
                            controller: _emailController,
                            hintText: "Email",
                          ),
                          const CustomSpacer(),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: "Password",
                          ),
                          const CustomSpacer(),
                          CustomButton(
                              buttonText: "Sign In",
                              onPressed: () {
                                //Handle Signin
                              })
                        ],
                      )),
                ),
            ],
          ),
        )));
  }
}
