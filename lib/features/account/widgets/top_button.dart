import 'package:amazon_clone/common/widgets/custom_spacer.dart';
import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Orders", onPressed: () {}),
            AccountButton(text: "Turn Seller", onPressed: () {})
          ],
        ),
        CustomSpacer(),
        Row(
          children: [
            AccountButton(text: "Log Out", onPressed: () {}),
            AccountButton(text: "Your Wish List", onPressed: () {})
          ],
        )
      ],
    );
  }
}
