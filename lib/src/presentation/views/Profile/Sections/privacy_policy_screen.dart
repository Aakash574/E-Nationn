// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: SizedBox(
            height: size.height * 2.4,
            child: Column(
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
                const SizedBox(height: 15),
                MyFont()
                    .fontSize26Bold("Privacy Policy", MyColors.primaryColor),
                const SizedBox(height: 15),
                MyFont().fontSize16Bold("Introduction", Colors.black),
                const SizedBox(height: 15),
                const Text(
                  """This Privacy Policy describes how ENATIONN ("we," "us," or "our") collects, uses, stores, and protects personal information of users ("you" or "user") when you use our mobile application ("Mobile App") and website ("Website"). We are committed to safeguarding your privacy and ensuring that your personal information is protected. By accessing or using our Mobile App or Website, you agree to the terms of this Privacy Policy.""",
                ),
                const SizedBox(height: 15),
                MyFont().fontSize16Bold(
                    "Collection of Personal Information", Colors.black),
                const SizedBox(height: 15),
                MyFont().fontSize16Bold(
                    "1.1 Personal Information Collected Directly",
                    Colors.black),
                const SizedBox(height: 15),
                const Text(
                  """When you use our Mobile App or Website, we may collect the following personal information directly from you:
                  \nNames\nPhone numbers\nEmail addresses\nMailing addresses\nJob titles\nUsernames\n\nYou may provide this information voluntarily, such as when you create an account, submit inquiries or feedback, or interact with certain features of our Mobile App or Website. We will only collect personal information that is necessary and relevant to provide you with the requested services or improve your experience.""",
                ),
                const SizedBox(height: 15),
                MyFont().fontSize16Bold(
                    "1.2 Personal Information Collected Automatically",
                    Colors.black),
                const SizedBox(height: 15),
                const Text(
                    """In addition to the personal information you provide, we may also collect certain information automatically when you use our Mobile App or Website, including:
                    \nDevice information: such as device type, operating system, and unique device identifiers.\nLog information: such as IP address, browser type, pages visited, and the date and time of your visit.\nUsage data: such as actions taken within the Mobile App or Website, preferences, and settings.\nThis information is collected through cookies, web beacons, and similar technologies. It helps us analyze trends, administer the Mobile App and Website, track user movements, and gather demographic information for internal purposes. You can control the use of cookies through your browser settings."""),
                const SizedBox(height: 15),
                MyFont().fontSize16Bold(
                    "Use of Personal Information", Colors.black),
                const SizedBox(height: 15),
                const Text(
                    """We may use the collected personal information for the following purposes:
                    \n • To provide and personalize our services to you, including user account creation, authentication, and communication.\n • To process transactions and fulfill your requests for products or services.\n • To respond to your inquiries, feedback, or customer support requests.\n • To improve our Mobile App and Website, enhance user experience, and develop new features.\n • To send you administrative information, updates, and promotional materials related to our services.\n • To detect and prevent fraudulent or unauthorized activities.\n • To comply with applicable laws, regulations, or legal processes.
                  \n"""),
                const SizedBox(height: 15),
                MyFont().fontSize16Bold(
                    "Sharing of Personal Information", Colors.black),
                const SizedBox(height: 15),
                const Text(
                    """We may share your personal information with third parties in the following circumstances:\n\nService Providers: We may engage trusted third-party service providers to perform certain functions or services on our behalf, such as hosting, data analysis, customer support, or marketing activities. These providers are bound by confidentiality obligations and are not permitted to use your personal information for any other purposes.\nLegal Compliance: We may disclose personal information if required to do so by law or in response to valid legal requests or processes.\nBusiness Transfers: In the event of a merger, acquisition, or sale of all or a portion of our assets, your personal information may be transferred to the acquiring entity or third party involved.\nConsent: We may share your personal information with your consent or at your direction.\n\nWe will not sell, rent, or disclose your personal information to third parties for their marketing purposes without your explicit consent."""),
                const SizedBox(height: 15),
                MyFont().fontSize16Bold("Data Security", Colors.black),
                const SizedBox(height: 15),
                const Flexible(
                  child: Text(
                      """We take reasonable measures to protect the security of your personal information and implement appropriate technical and organizational measures to safeguard against unauthorized access, loss, misuse, alteration, or disclosure of your information. However, no method of transmission over the internet or electronic storage is 100% secure. Therefore, while we strive to protect your personal information, we cannot guarantee its absolute security.
Your Rights and Choices
                      """),
                ),
                TextButton(
                  onPressed: () {
                    // Email ------------------------>

                    _launchEmail("support@enationn.com");
                  },
                  child: Text(
                    "support@enationn.com",
                    style: TextStyle(color: MyColors.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchEmail(email) async {
    final url = Uri.parse('mailto:$email?subject=&body=');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
