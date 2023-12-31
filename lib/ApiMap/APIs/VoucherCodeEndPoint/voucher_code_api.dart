// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PaymentVoucherApiClient {
  Future<List<dynamic>> getVoucherCode() async {
    log("Getting all Voucher Code ......");

    Uri voucherCodeApi =
        Uri.parse('http://13.232.155.227:8000/account/api/Payment_Voucher/');
    Response response = await http.get(
      voucherCodeApi,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<dynamic> voucherCode = await jsonDecode(response.body);
    log(voucherCode.toString());

    return voucherCode;
  }

  Future<bool> validVoucherCode(String userVoucherCode) async {
    log("Validating Voucher Code .........");

    Uri voucherCodeApi =
        Uri.parse('http://13.232.155.227:8000/account/api/Payment_Voucher/');
    Response response = await http.get(
      voucherCodeApi,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final voucherCode = await jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (var i = 0; i < voucherCode.length; i++) {
        if (userVoucherCode == voucherCode[i]['payment_voucher_code']) {
          return true;
        }
      }
    }

    return false;
  }

  Future<String> getIdByVoucherCode(String userVoucherCode) async {
    log("getting Id Voucher code....");

    Uri voucherCodeApi =
        Uri.parse('http://13.232.155.227:8000/account/api/Payment_Voucher/');
    Response response = await http.get(
      voucherCodeApi,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final voucherCode = await jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (var i = 0; i < voucherCode.length; i++) {
        if (userVoucherCode == voucherCode[i]['payment_voucher_code']) {
          return voucherCode[i]['id'].toString();
        }
      }
    }

    return "Voucher Code Not Found";
  }

  Future<bool> deleteVoucherCode(String id) async {
    log(id);
    Uri voucherCodeApi = Uri.parse(
        'http://13.232.155.227:8000/account/api/Payment_Voucher/$id/');

    Response response = await http.delete(voucherCodeApi);

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log("Delete SuccessFully");
      return true;
    }
    return false;
  }
}
