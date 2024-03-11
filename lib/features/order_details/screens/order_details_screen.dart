import 'package:amazon_clone/common/widgets/custom_spacer.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    currentStep = widget.order.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                          hintText: "Search Amazon.UK",
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1)),
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'View order details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Order Date:    ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))} '),
                    Text("Order ID:        ${widget.order.id}"),
                    Text("Order ID:        £${widget.order.totalPrice}")
                  ],
                ),
              ),
              const CustomSpacer(),
              Text(
                'Purchase Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(children: [
                        Image.network(
                          widget.order.products[i].images[0],
                          height: 120,
                          width: 120,
                        ),
                        const CustomSpacer(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.products[i].name,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Qty: ${widget.order.quantity[i]}",
                              ),
                            ],
                          ),
                        )
                      ])
                  ],
                ),
              ),
              const CustomSpacer(),
              Text(
                'Tracking',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Stepper(
                      currentStep: currentStep,
                      controlsBuilder: (context, details) {
                        return const SizedBox();
                      },
                      steps: [
                        Step(
                            isActive: currentStep > 0,
                            state: currentStep > 0
                                ? StepState.complete
                                : StepState.indexed,
                            title: Text("Pending"),
                            content:
                                Text("Your order is pending confirmation...")),
                        Step(
                            isActive: currentStep > 1,
                            state: currentStep > 1
                                ? StepState.complete
                                : StepState.indexed,
                            title: Text("Processing"),
                            content: Text("Your order is on its way.")),
                        Step(
                            isActive: currentStep > 2,
                            state: currentStep > 2
                                ? StepState.complete
                                : StepState.indexed,
                            title: Text("Shipped"),
                            content: Text("Your order is on its way to you.")),
                        Step(
                            isActive: currentStep >= 3,
                            state: currentStep >= 3
                                ? StepState.complete
                                : StepState.indexed,
                            title: Text("Completed"),
                            content: Text(
                                "Order completed. Thank you for shopping with us."))
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
