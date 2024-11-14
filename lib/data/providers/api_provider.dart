import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<dynamic> get({required String endpoint}) async {
    if (kDebugMode) {
      print(endpoint);
    }
    try {
      final response = await http.get(Uri.parse(endpoint));
      return returnResponse(response);
    } catch (e) {
      log(e.toString());
    }
    return;
  }

  Future<dynamic> post({
    required String endpoint,
    dynamic body,
  }) async {
    if (kDebugMode) {
      print(endpoint);
    }
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        body: body,
      );
      return returnResponse(response);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> delete({
    required String endpoint,
  }) async {
    if (kDebugMode) {
      print(endpoint);
    }
    try {
      final response = await http.delete(
        Uri.parse(endpoint),
      );
      return returnResponse(response);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        log(response.statusCode.toString());
        log(response.body.toString());
        return responseJson;
      case 400:
        log("${response.statusCode}");
        log(response.body);
        throw Exception;
    }
  }
}
