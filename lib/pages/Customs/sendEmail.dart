import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../../Provider/basic_variables_provider.dart';
import '../../Provider/user_provider.dart';

class SendEmail {
  static void sendEmail(
    BuildContext context,
    subject,
    String body,
    String recipientEmail,
  ) async {
    String username = 'noreply@enationn.com'; // Your email address
    String password = 'Enationnapp@2020'; // Your email password

    final smtpServer = SmtpServer(
      'smtp.hostinger.com',
      username: username,
      password: password,
      port: 587, // Replace with your SMTP server port
      // tls: true, // Use SSL/TLS
    );

    final message = Message()
      ..from = Address(username, 'E-Nationn') // Your name and email address
      ..recipients.add(recipientEmail) // Recipient's email address
      ..subject = subject
      ..text = body; // Plain text body

    var htmlTamplate = "";
    message.html = htmlTamplate;
    try {
      final sendReport = await send(message, smtpServer);
      log('Message sent: ${sendReport.toString()}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email sent!'),
        ),
      );
    } catch (e) {
      log('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to send email. Please try again.')),
      );
    }
  }

  Future<bool> sendMail(
    BasicVariableModel basicVariable,
    UserProvider userProvider,
    String body,
    String subject,
  ) async {
    String username = 'enationnindia@gmail.com'; // Your email address
    String password = 'svklvaghqzvgvmvl';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'E-Nationn')
      ..recipients.add(userProvider.email)
      ..subject = subject
      ..text = 'Verification Code ::'
      ..html = body;

    try {
      final sendReport = await send(message, smtpServer);
      log(sendReport.mail.toString());
      print('Message sent: $sendReport');
      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      log(e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}
