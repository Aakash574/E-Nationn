// ignore_for_file: file_names, unused_local_variable

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/basic_variables_provider.dart';
import '../PassCodeScreen/pass_Code_Screen.dart';
import 'payment_Method_Screen.dart';

class PremiumPaymentScreen extends StatefulWidget {
  const PremiumPaymentScreen({super.key});

  @override
  State<PremiumPaymentScreen> createState() => _PremiumPaymentScreenState();
}

class _PremiumPaymentScreenState extends State<PremiumPaymentScreen> {
  String date = DateFormat("MMMM dd, yyyy").format(DateTime.now());
  double width = 30;

  @override
  Widget build(BuildContext context) {
    final screen = Provider.of<BasicVariableModel>(context);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Material(
        color: MyColors.primaryColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: size.height / 1.9,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage(
                      "assets/PaymentScreenImg/paymentScreenBlueBackground.png",
                    ),
                    scale: 5,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: const Color(0xff6B7280).withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/PaymentScreenImg/paymentLogo.png",
                            scale: 2,
                          ),
                          const Text(
                            "Premium Plan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Payment on $date",
                            // date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 50),
                          MyFont().fontSize26Bold("RS-999", Colors.white),
                          const SizedBox(height: 20),
                          Container(
                            width: size.width,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.white,
                                  // size: 1,
                                ),
                                Text(
                                  "Lorem ipsum is placeholder text",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Spacer(),
              Container(
                width: size.width,
                height: size.height / 2.5,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Container(
                  margin: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        // margin: const EdgeInsets.all(24),
                        height: 5,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      const Text(
                        "Choose Payment Option",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const PaymentMethodScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 72,
                          width: size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 45,
                                height: 40,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/PaymentScreenImg/paymentMethodLogo.png"),
                                    scale: 3,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  // color: Colors.white,
                                ),
                              ),
                              const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    "Phone Pay",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "3890-2584-XXXX",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                              const SizedBox(width: 110),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: 56,
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            screen.setWhichScreen("PaymentScreen");
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const PassCodeScreen();
                                },
                              ),
                              (route) => false,
                            );
                          },
                          style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory),
                          child: const Text(
                            "Proceed to Pay",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
