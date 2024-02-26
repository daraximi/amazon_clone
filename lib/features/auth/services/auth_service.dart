// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_navbar.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //Sign Up User
  void signUpUser(
      {required String email,
      required BuildContext context,
      required String password,
      required String name}) async {
    try {
      User user = User(
          id: '',
          token: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          cart: []);

      var response = await http.post(Uri.parse("$uri/api/signup"),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account created! Login with same credentials');
          });
    } catch (e) {
      //Do error later.
      showSnackBar(context, e.toString());
    }
  }

  //Logging in user
  void signInUser({
    required String email,
    required BuildContext context,
    required String password,
  }) async {
    try {
      var response = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      print(response.body);
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);
            prefs.setString('x-auth-token', jsonDecode(response.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //Getting User data
  //Logging in user
  void getUserData(
    BuildContext context,
  ) async {
    try {
      //Implement Get User Data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenResponse = await http
          .post(Uri.parse('$uri/validateToken'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });
      var response = jsonDecode(tokenResponse.body);
      if (response) {
        //get User data
        var userResponse =
            await http.get(Uri.parse('$uri/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      } else {
        prefs.setString('x-auth-token', '');
        //Go to sign up screen
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
