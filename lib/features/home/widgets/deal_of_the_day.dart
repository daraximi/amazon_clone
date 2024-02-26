import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailsScreen() async {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailsScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        "Deal of the day",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text(
                        "\$9.99",
                        style: TextStyle(fontSize: 18),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 50),
                      child: const Text(
                        "Dara",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.images
                              .map((e) => Image.network(
                                    e,
                                    fit: BoxFit.fitWidth,
                                    width: 100,
                                    height: 100,
                                  ))
                              .toList()),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 15)
                            .copyWith(left: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "See all deals",
                          style: TextStyle(
                              fontSize: 18, color: Colors.cyan.shade800),
                        ))
                  ],
                ),
              );
  }
}
