// ignore_for_file: use_build_context_synchronously, file_names, avoid_print

import 'dart:math';
import 'dart:developer' as d;
// import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:enationn/ApiMap/APIs/UserEndPoints/login_api.dart';
import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';

import 'otp_Screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool isSendingOTP = false;
  bool isFound = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final basicVariable = Provider.of<BasicVariableModel>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  const Spacer(),
                  MyFont().fontSize16Bold(widget.title, Colors.black),
                  const Spacer(),
                  const SizedBox(width: 30),
                ],
              ),
              const Spacer(),
              MyFont().fontSize16Bold("Enter Your Email", Colors.black),
              const SizedBox(height: 20),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: isFound
                      ? Border.all(
                          width: 1,
                          color: EmailValidator.validate(_emailController.text)
                              ? isFound
                                  ? Colors.green
                                  : Colors.red
                              : MyColors.primaryColor,
                        )
                      : _emailController.text.isEmpty
                          ? Border.all(
                              width: 1,
                              color: MyColors.primaryColor,
                            )
                          : Border.all(
                              width: 1,
                              color: Colors.red,
                            ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withOpacity(0.10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: MyColors.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) async {
                          d.log(
                              "Email Found : ${await LoginApiClient().getUserDataByEmail(_emailController.text, 'email') == _emailController.text}");
                          final email = await LoginApiClient()
                              .getUserDataByEmail(
                                  _emailController.text, 'email');
                          setState(() {
                            if (email == _emailController.text) {
                              isFound = true;
                            } else {
                              isFound = false;
                            }
                          });
                        },
                      ),
                    ),
                    const Spacer(),
                    EmailValidator.validate(_emailController.text)
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : _emailController.text.isEmpty
                            ? Container()
                            : const Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerRight,
                child: isFound
                    ? MyFont().fontSize14Bold("Verified", Colors.green)
                    : null,
              ),
              // const SizedBox(height: 20.0),
              const Spacer(),
              InkWell(
                onTap: () async {
                  if (userProvider.email == _emailController.text) {
                    setState(() {
                      isSendingOTP = true;
                    });

                    if (await sendMail(basicVariable, userProvider)) {
                      setState(() {
                        isSendingOTP = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return const OTPScreen();
                          },
                        ),
                      );
                    }
                  } else if (_emailController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Please enter the email first!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "Email is not registered",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: MyColors.primaryColor,
                  ),
                  child: Center(
                    child: isSendingOTP
                        ? const CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: Colors.white,
                          )
                        : MyFont()
                            .fontSize14Weight700("Send Code", Colors.white),
                  ),
                ),
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> sendMail(
      BasicVariableModel basicVariable, UserProvider userProvider) async {
    String username = 'enationnindia@gmail.com'; // Your email address
    String password = 'svklvaghqzvgvmvl';

    final smtpServer = gmail(username, password);

    d.log("email Sending");

    final message = Message()
      ..from = Address(username, 'E-Nationn')
      ..recipients.add(_emailController.text)
      ..subject = 'E-Nationn email verification Code :: 😀'
      ..text = 'Verification Code ::'
      ..html = setEmailBody(userProvider, basicVariable);

    try {
      final sendReport = await send(message, smtpServer);
      d.log(sendReport.mail.toString());
      print('Message sent: $sendReport');
      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      d.log(e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}

String setEmailBody(
    UserProvider userProvider, BasicVariableModel basicVariable) {
  Random random = Random();
  int next(int min, int max) => min + random.nextInt(max - min);
  final rand = next(999, 9999);

  basicVariable.setVerificationCode(rand.toString());

  String mailBody = """
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            background-image: url('technologies_background.jpg');
            background-repeat: no-repeat;
            background-size: cover;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .header {
            text-align: center;
        }

        h1 {
            margin: 0;
            font-size: 36px;
            font-weight: bold;
            color: #333333;
            padding: 20px 0;
            border-bottom: 1px solid #cccccc;
        }

        .content {
            margin-top: 20px;
            padding: 20px;
            border-radius: 10px;
            background-color: rgba(255, 255, 255, 0.9);
        }

        .text {
            color: #333333;
            margin: 0;
            font-size: 18px;
            line-height: 1.5;
            margin-bottom: 10px;
        }

        .quote {
            margin-top: 20px;
            padding: 10px;
            background-color: #f1f1f1;
            border-radius: 10px;
            font-style: italic;
            font-size: 14px;
            color: #666666;
            text-align: center;
        }

        .highlight {
            background-color: #efefef;
            padding: 15px;
            border-radius: 20px;
            font-size: 36px;
            font-weight: bold;
            text-align: center;
            margin: 20px 0;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        .company-name {
            font-size: 24px;
            font-weight: bold;
            color: #333333;
            text-align: center;
            margin-top: 20px;
            text-transform: uppercase;
        }

        .footer {
            margin-top: 20px;
            text-align: center;
            font-size: 14px;
            color: #666666;
            border-top: 1px solid #cccccc;
            padding-top: 20px;
        }

        .social-icons {
            align-items: center;

            list-style: none;
            padding: 0;
            margin: 10px 0;
            display: flex;
            justify-content: center;
        }

        .social-icons li {
            margin: 0 5px;
        }

        .social-icons li a {
            display: flex;
            flex-direction: column;
            align-items: center;
            color: #666666;
            text-decoration: none;
            font-size: 12px;
            transition: color 0.3s;
        }

        .social-icons li a img {
            width: 32px;
            height: 32px;
            margin-bottom: 5px;
        }

        .social-icons li a:hover {
            color: #333333;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="header">
            <h1> Welcome to E-Nationn!
            </h1>
        </div>
        <div class="content">
            <p class="text">Dear ${userProvider.fullName},</p>
            <p class="text">Your OTP is:</p>
            <div class="highlight">{{$rand}}</div>
            <p class="text">Please use this verification code to proceed with your account registration.</p>
            <div class="quote">"Success is not final, failure is not fatal: It is the courage to continue that counts."
            </div>
        </div>
        <div class="footer">
            <ul class="social-icons">
                <li>
                    <a href="#">
                        <i class="fa fa-facebook"></i>
                        Facebook
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fa fa-twitter"></i>
                        Twitter
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fa fa-instagram"></i>
                        Instagram
                    </a>
                </li>
                <li>
                    <i class="fa fa-linkedin"></i>
                    <a href="https://www.linkedin.com/" target="_blank">
                        LinkedIn
                    </a>
                </li>
                <li>
                    <i class="fa fa-youtube"></i>
                    <a href="https://www.youtube.com/@Enationn" target="_blank">
                        Youtube
                    </a>
                </li>
            </ul>
            <p>&copy; 2023 E-Nationn. All rights reserved.</p>
            <p>${DateTime.now()}</p>
        </div>
    </div>
</body>""";
  return mailBody;
}
