// ignore_for_file: file_names

import 'dart:developer';
import 'dart:io';

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: MyColors.lightGreyColor.withOpacity(0.2),
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

              MyFont().fontSize26Bold("Contact us", Colors.black),

              // Whatsapp ------------------------>

              sharingSections(
                () {
                  _launchWhatsapp('+919302707264');
                },
                const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.green,
                  size: 30,
                ),
                'Whatsapp',
                '+91 9302707264',
              ),

              // LinkedIn ------------------------>

              sharingSections(
                () {
                  final Uri url =
                      Uri.parse('https://www.linkedin.com/company/e-nationn/');
                  launchSharingOption(url);
                },
                FaIcon(
                  FontAwesomeIcons.linkedin,
                  color: MyColors.primaryColor,
                  size: 30,
                ),
                'LinkedIn',
                'https://www.linkedin.com/company/e-nationn/',
              ),

              // Instagram ------------------------>

              sharingSections(
                () {
                  final Uri url =
                      Uri.parse('https://www.instagram.com/enationn/');
                  launchSharingOption(url);
                },
                const FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Colors.red,
                  size: 30,
                ),
                'Instagram',
                'https://www.instagram.com/enationn/',
              ),

              // Youtube ------------------------>

              sharingSections(
                () {
                  _launchYoutube();
                },
                const FaIcon(
                  FontAwesomeIcons.youtube,
                  color: Colors.red,
                  size: 30,
                ),
                'Youtube',
                'https://youtube.com/@ENationn',
              ),

              // Email ------------------------>

              sharingSections(
                () {
                  _launchEmail('support@enationn.com');
                },
                FaIcon(
                  FontAwesomeIcons.at,
                  color: MyColors.primaryColor,
                  size: 30,
                ),
                'Gmail',
                'support@enationn.com',
              ),

              // Call ------------------------>

              sharingSections(
                () {
                  _launchCaller();
                },
                FaIcon(
                  FontAwesomeIcons.phone,
                  color: MyColors.primaryColor,
                  size: 30,
                ),
                'Phone',
                'tel: +91 9302707264',
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchSharingOption(url) async {
    try {
      if (await canLaunchUrl(url)) {
        log("Launch");
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      log(e.toString());
    }
  }

  _launchYoutube() async {
    Uri url = Uri.parse('https://youtube.com/@ENationn');
    if (Platform.isIOS) {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'Could not launch $url';
        }
      }
    } else {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  _launchWhatsapp(whatsapp) async {
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  _launchCaller() async {
    final Uri url = Uri.parse("tel:+919302707264");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchEmail(email) async {
    final url = Uri.parse('mailto:$email?subject=&body=');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ListTile sharingSections(onTap, leadingIcon, title, subtitle) {
    return ListTile(
      onTap: onTap,
      leading: leadingIcon,
      contentPadding: EdgeInsets.zero,
      title: MyFont().fontSize16Bold(
        title,
        Colors.black,
      ),
      subtitle: MyFont().fontSize14Weight500(
        subtitle,
        MyColors.darkGreyColor,
      ),
      trailing: const SizedBox(
        width: 100,
        child: Row(
          children: [
            Spacer(),
            FaIcon(
              FontAwesomeIcons.angleRight,
              color: Colors.black,
              size: 24,
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
