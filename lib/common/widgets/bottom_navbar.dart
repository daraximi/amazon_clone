// ignore_for_file: prefer_final_fields

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual_home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> _pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(child: Text('Cart')),
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: _pages[_page],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          backgroundColor: GlobalVariables.backgroundColor,
          iconSize: 28,
          onTap: updatePage,
          items: [
            //Home
            BottomNavigationBarItem(
                label: '',
                icon: Container(
                    child: const Icon(Icons.home_outlined),
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                      border: Border(
                          top: _page == 0
                              ? BorderSide(
                                  color: _page == 0
                                      ? GlobalVariables.selectedNavBarColor
                                      : GlobalVariables.unselectedNavBarColor,
                                  width: bottomBarBorderWidth)
                              : BorderSide.none),
                    ))),
            //Profile
            BottomNavigationBarItem(
                label: '',
                icon: Container(
                  child: const Icon(Icons.person_outlined),
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                      border: Border(
                          top: _page == 1
                              ? BorderSide(
                                  color: _page == 1
                                      ? GlobalVariables.selectedNavBarColor
                                      : GlobalVariables.unselectedNavBarColor,
                                  width: bottomBarBorderWidth)
                              : BorderSide.none)),
                )),
            //Cart
            BottomNavigationBarItem(
                label: '',
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                      border: Border(
                          top: _page == 2
                              ? BorderSide(
                                  color: _page == 2
                                      ? GlobalVariables.selectedNavBarColor
                                      : GlobalVariables.unselectedNavBarColor,
                                  width: bottomBarBorderWidth)
                              : BorderSide.none)),
                  child: badges.Badge(
                      badgeStyle: badges.BadgeStyle(badgeColor: Colors.white),
                      badgeContent: Text(userCartLength.toString()),
                      child: Icon(Icons.shopping_cart_outlined)),
                ))
          ]),
    );
  }
}
