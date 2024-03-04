import 'dart:convert';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress(
      {required BuildContext context, required String address}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      //POST TO SERVER
      var response = await http.post(Uri.parse('$uri/api/save-user-address'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({'address': address}));
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            debugPrint(response.body);
            User user = userProvider.user
                .copyWith(address: jsonDecode(response.body)['address']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //Place an order
  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalSum}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum
          }));

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Your order has been placed");
            Future.delayed(Duration(seconds: 2)).then((value) {
              Navigator.of(context).pop();
            });
            User user = userProvider.user.copyWith(cart: []);
            userProvider.setUserFromModel(user);
            debugPrint(response.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
