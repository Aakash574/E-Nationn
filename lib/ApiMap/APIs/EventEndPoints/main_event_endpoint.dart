// ignore_for_file: file_names
// // ignore_for_file: file_names

// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class MainEventAPIClient {
//   Future<void> checkForUpdates(previousData) async {
//     final response = await http
//         .get(Uri.parse('http://13.232.155.227:8000/account/api/Events/'));

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       // Compare the response data with the previous data to detect updates
//       if (responseData != previousData) {
//         // Data has been updated, perform necessary actions
//         // For example, show a notification or update the UI
//         print('API data has been updated!');

//         // Update the previous data with the new data
//         previousData = responseData;
//       } else {
//         // No updates found
//         print('No updates found in the API data.');
//       }
//     } else {
//       // Handle API request error
//       print('Error accessing the API: ${response.statusCode}');
//     }
//   }
// }
