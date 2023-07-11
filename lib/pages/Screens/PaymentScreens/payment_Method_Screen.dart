// ignore_for_file: file_names, must_be_immutable

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String isActive = "";
  bool isClose = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.97),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: const Color(0xff6B7280).withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 14,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          // print("object");
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    MyFont().fontSize16Bold("Payment Methods", Colors.black),
                  ],
                ),
                const SizedBox(height: 15),
                sectionsForPayments(size, "RECOMMENDED", 160),
                const SizedBox(height: 5),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          isActive = "GooglePayUPI";
                          isClose = !isClose;
                          setState(() {});
                        },
                        child: SizedBox(
                          height: isActive == "GooglePayUPI" ? 200 : 35,
                          child: Column(
                            children: [
                              PaymentMethodCard(
                                methodName: 'Google Pay UPI',
                                paymentIconName: 'googlepay',
                              ),
                              isActive == "GooglePayUPI"
                                  ? const UPIId()
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      decoration(size),
                      InkWell(
                        onTap: () {
                          isActive = "Example";
                          setState(() {});
                        },
                        child: SizedBox(
                          height: isActive == "Example" ? 200 : 35,
                          child: Column(
                            children: [
                              PaymentMethodCard(
                                methodName: 'example@ybl',
                                paymentIconName: 'upi',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                sectionsForPayments(size, "CARDS", 90),
                const SizedBox(height: 5),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          isActive = "CreditDebit";
                          setState(() {});
                        },
                        child: SizedBox(
                          height: isActive == "CreditDebit" ? 200 : 35,
                          child: Column(
                            children: [
                              PaymentMethodCard(
                                methodName: 'Add Credit or Debit Cards',
                                paymentIconName: 'creditcards',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                sectionsForPayments(size, "UPI", 60),
                const SizedBox(height: 5),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          isActive = "PaytmUPI";
                          setState(() {});
                        },
                        child: SizedBox(
                          height: isActive == "PaytmUPI" ? 200 : 35,
                          child: PaymentMethodCard(
                            methodName: 'Paytm UPI',
                            paymentIconName: 'paytm',
                          ),
                        ),
                      ),
                      decoration(size),
                      InkWell(
                        onTap: () {
                          isActive = "PhonePe";
                          setState(() {});
                        },
                        child: SizedBox(
                          height: isActive == "PhonePe" ? 200 : 35,
                          child: PaymentMethodCard(
                            methodName: 'PhonePe UPI',
                            paymentIconName: 'phonepe',
                          ),
                        ),
                      ),
                      decoration(size),
                      InkWell(
                        onTap: () {
                          isActive = "UPI@ybl";
                          setState(() {});
                        },
                        child: SizedBox(
                          height: isActive == "UPI@ybl" ? 200 : 35,
                          child: PaymentMethodCard(
                            methodName: '78951484@ybl',
                            paymentIconName: 'upi',
                          ),
                        ),
                      ),
                      decoration(size),
                      InkWell(
                        onTap: () {
                          isActive = "NewUPI";
                          setState(() {});
                        },
                        child: SizedBox(
                          height: isActive == "NewUPI" ? 200 : 35,
                          child: PaymentMethodCard(
                            methodName: 'Add new UPI ID',
                            paymentIconName: 'upi',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                sectionsForPayments(size, "WALLETS", 110),
                const SizedBox(height: 5),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          isActive = "Paytm";
                          setState(() {});
                        },
                        child: SizedBox(
                          height: isActive == "Paytm" ? 200 : 35,
                          child: PaymentMethodCard(
                            methodName: 'Paytm',
                            paymentIconName: 'paytm',
                          ),
                        ),
                      ),
                      decoration(size),
                      InkWell(
                        onTap: () {
                          isActive = "Mobikwik";
                          setState(() {});
                        },
                        child: SizedBox(
                          height: isActive == "Mobikwik" ? 200 : 35,
                          child: PaymentMethodCard(
                            methodName: 'Mobikwik',
                            paymentIconName: 'Mobikwik',
                          ),
                        ),
                      ),
                      decoration(size),
                      InkWell(
                        onTap: () {
                          isActive = "FreeCharge";
                          setState(() {});
                        },
                        child: SizedBox(
                          height: isActive == "FreeCharge" ? 200 : 35,
                          child: PaymentMethodCard(
                            methodName: 'FreeCharge',
                            paymentIconName: 'freecharge',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                sectionsForPayments(size, "NETBANKING", 150),
                const SizedBox(height: 5),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: PaymentMethodCard(
                          methodName: 'NetBanking',
                          paymentIconName: 'netbanking',
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 15),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row sectionsForPayments(Size size, String sectionName, double wordSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // alignment: Alignment.centerLeft,
      children: [
        Container(
          height: 1,
          width: size.width / 4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MyColors.primaryColor,
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                MyColors.primaryColor,
                // Colors.transparent,
              ],
            ),
          ),
        ),
        Container(
          width: wordSize + 10,
          height: 35,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Text(
            sectionName,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
              letterSpacing: 5,
            ),
          ),
        ),
        Container(
          height: 1,
          width: size.width / 4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MyColors.primaryColor,
            gradient: LinearGradient(
              colors: [
                // Colors.transparent,
                MyColors.primaryColor,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- Simple Decoration -------------->

  Column decoration(var size) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Container(
          width: size.width,
          height: 1,
          color: Colors.grey[200],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

// ---------------- PaymentMethodCard ------------------->
@immutable
class PaymentMethodCard extends StatelessWidget {
  final String methodName;
  final String paymentIconName;
  bool dropBox = false;
  PaymentMethodCard({
    super.key,
    required this.methodName,
    required this.paymentIconName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            PaymentIcon(
              iconName: paymentIconName,
            ),
            const SizedBox(width: 15),
            MyFont().fontSize12Bold(
              methodName,
              Colors.black,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
            ),
          ],
        ),
        // SizedBox(height: 10),
      ],
    );
  }
}

class PaymentIcon extends StatelessWidget {
  final String iconName;
  const PaymentIcon({super.key, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Image.asset(
          "assets/PaymentMethodIcons/$iconName.png",
          scale: 18,
        ));
  }
}

// -------------- Payment Adding Method ------------->

// ------------------- Cards And Sodexo ------------>

class Cards extends StatefulWidget {
  const Cards({super.key});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

//-------------------- UPI ------------------------->

class UPIId extends StatefulWidget {
  const UPIId({super.key});

  @override
  State<UPIId> createState() => _UPIIdState();
}

class _UPIIdState extends State<UPIId> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            // color: Colors.red,
            border: Border.all(width: 1, color: MyColors.primaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Enter Your UPI",
              hintStyle: TextStyle(
                fontSize: 14,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
        MyFont().fontSize12Weight500(
          "If you Don't have a Paytm Wallet,it will be Created.",
          MyColors.darkGreyColor,
        ),
        const SizedBox(height: 10),
        Container(
          width: size.width,
          height: 50,
          decoration: BoxDecoration(
            color: MyColors.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextButton(
            onPressed: () {},
            style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
            child: MyFont().fontSize16Bold("Link UPI", Colors.white),
          ),
        ),
      ],
    );
  }
}

//-------------------- Wallets --------------------->

class Wallets extends StatefulWidget {
  const Wallets({super.key});

  @override
  State<Wallets> createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            // color: Colors.red,
            border: Border.all(width: 1, color: MyColors.primaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Mobile Number",
              hintStyle: TextStyle(
                fontSize: 14,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
        MyFont().fontSize12Weight500(
          "If you Don't have a Paytm Wallet,it will be Created.",
          MyColors.darkGreyColor,
        ),
        const SizedBox(height: 10),
        Container(
          width: size.width,
          height: 50,
          decoration: BoxDecoration(
            color: MyColors.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextButton(
            onPressed: () {},
            style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
            child: MyFont().fontSize16Bold("Link Wallet", Colors.white),
          ),
        ),
      ],
    );
  }
}

//-------------------- Net banking --------------------->

class NetBanking extends StatefulWidget {
  const NetBanking({super.key});

  @override
  State<NetBanking> createState() => _NetBankingState();
}

class _NetBankingState extends State<NetBanking> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(),
      ),
    );
  }
}
