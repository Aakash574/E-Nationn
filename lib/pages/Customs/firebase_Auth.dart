// ignore_for_file: file_names
// import 'package:firebase_auth/firebase_auth.dart';

// Future<void> sendVerificationCode(String email) async {
//   try {
//     await FirebaseAuth.instance.sendSignInWithEmailLink(
//       email: email,
//       actionCodeSettings: ActionCodeSettings(
//         url: 'YOUR_REDIRECT_URL',
//         androidPackageName: 'com.example.yourapp',
//         handleCodeInApp: true,
//         iOSBundleId: 'com.example.yourapp',
//         dynamicLinkDomain: 'yourapp.page.link',
//       ),
//     );
//     print('Verification code sent to $email');
//   } catch (e) {
//     print('Error sending verification code: $e');
//   }
// }

// Future<void> verifyCode(String email, String code) async {
//   try {
//     final UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithEmailLink(
//       email: email,
//       emailLink:
//           'YOUR_REDIRECT_URL', // Same as the one used in sendVerificationCode()
//     );
//     print('Email verified for user: ${userCredential.user!.email}');
//     // Proceed with your app logic after successful verification
//   } catch (e) {
//     print('Error verifying code: $e');
//     // Handle verification failure
//   }
// }
