import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
          type: '');

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

  //Getting new User
}
