import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_spacer.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  final String amount;
  static const String routeName = '/address';
  const AddressScreen({super.key, required this.amount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(PaymentItem(
        label: "Total amount",
        amount: widget.amount,
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    zipCodeController.dispose();
    townController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context).user.address.isEmpty) {}
  }

  void onGooglePlayResult(res) {}

  void onPayPressed(String addressFromProvider) {
    addressToBeUsed = "";
    bool isFormUsed = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        zipCodeController.text.isNotEmpty ||
        townController.text.isNotEmpty;
    if (isFormUsed) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${flatBuildingController.text}, ${areaController.text}, ${townController.text}, ${zipCodeController.text}";
      } else {
        throw Exception('Please enter all the fields in the form');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, "ERROR");
    }
    debugPrint(addressToBeUsed);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    //var address = "101, Fake Street, Fake Town, 123444";
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const CustomSpacer(),
                    const Text(
                      "OR",
                      style: TextStyle(fontSize: 18),
                    ),
                    const CustomSpacer(),
                  ],
                ),
              Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      const CustomSpacer(),
                      CustomTextField(
                        controller: flatBuildingController,
                        hintText: "Flat, House no., Buildingt",
                      ),
                      const CustomSpacer(),
                      CustomTextField(
                        controller: areaController,
                        hintText: "Area, Street",
                      ),
                      const CustomSpacer(),
                      CustomTextField(
                        controller: zipCodeController,
                        hintText: "Zip Code",
                      ),
                      const CustomSpacer(),
                      CustomTextField(
                        controller: townController,
                        hintText: "Town/City",
                      ),
                      const CustomSpacer(),
                    ],
                  )),
              CustomSpacer(),
              ApplePayButton(
                  onPressed: () => onPayPressed(address),
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(top: 15),
                  style: ApplePayButtonStyle.whiteOutline,
                  type: ApplePayButtonType.buy,
                  onPaymentResult: onApplePayResult,
                  paymentConfiguration: PaymentConfiguration.fromJsonString(
                      GlobalVariables.defaultApplePay),
                  paymentItems: paymentItems),
              CustomSpacer(),
              GooglePayButton(
                  onPressed: () => onPayPressed(address),
                  type: GooglePayButtonType.buy,
                  paymentConfiguration: PaymentConfiguration.fromJsonString(
                      GlobalVariables.defaultGooglePay),
                  onPaymentResult: onGooglePlayResult,
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(top: 15),
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(
                      color: GlobalVariables.secondaryColor,
                    ),
                  ),
                  paymentItems: paymentItems)
            ],
          ),
        ),
      ),
    );
  }
}
