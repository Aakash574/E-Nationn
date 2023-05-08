// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.black,
      decoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage("assets/ProfileScreen/profileBackground.png"),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 45),
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 35),
                    const Text(
                      "General",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      height: 72,
                      padding: const EdgeInsets.only(
                          top: 10, right: 10, bottom: 10, left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue[100],
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.shield_moon,
                                color: MyColors.primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Security",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Your Password Acount",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 50),
                          // Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 72,
                      // padding: EdgeInsets.all(10),
                      padding: const EdgeInsets.only(
                          top: 10, right: 10, bottom: 10, left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue[100],
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.headphones,
                                color: MyColors.primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Help",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Need More Help",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 50),
                          // Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 72,
                      // padding: EdgeInsets.all(10),
                      padding: const EdgeInsets.only(
                          top: 10, right: 10, bottom: 10, left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue[100],
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.privacy_tip_sharp,
                                color: MyColors.primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Your Acount Privacy",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 50),
                          // Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        setState(() {
                          // ApiClient.login(, password)
                        });
                      },
                      child: Container(
                        height: 72,
                        // padding: EdgeInsets.all(10),
                        padding: const EdgeInsets.only(
                            top: 10, right: 10, bottom: 10, left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue[100],
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.logout_outlined,
                                  color: MyColors.primaryColor,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            // const SizedBox(width: 100),
                            // Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 45,
                backgroundImage: const AssetImage(
                  "assets/ProfileScreen/profile.png",
                  // scale: 2,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.transparent,
                    border: Border.all(
                      width: 5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
