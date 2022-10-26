import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shokuni_customer/services/api_response.dart';
import 'package:shokuni_customer/services/app_exception.dart';
import 'package:shokuni_customer/utils/utils.dart';

class ApiBaseHelper {
  static dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        var responseJson = json.decode(response.body.toString());
        CustomAlertDialog.sessionExpired();
        return responseJson;
      case 422:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 510:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  //Get Method
  static Future<ApiResponse> getAPI(String url, String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "content-type": "application/json",
          //"access-control-allow-origin": '*',
          'Authorization': accessToken,
        },
      );
      var responseJson = _returnResponse(response);

      return ApiResponse.completed(responseJson);
    } on SocketException {
      CustomAlertDialog.noConnectionAlert();
      return ApiResponse.error('No Internet connection');
    }
  }

  static Future<ApiResponse> getAPIwithBODY(
      String url, String accessToken, Map body) async {
    try {
      final _url = Uri.parse(url);
      final request = http.Request("GET", _url);
      request.headers.addAll(
        <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "*/*",
          'Authorization': accessToken,
        },
      );
      request.body = jsonEncode(body);
      final response = await request.send();
      var res = await http.Response.fromStream(response);
      var responseJson = _returnResponse(res);

      return ApiResponse.completed(responseJson);
    } on SocketException {
      CustomAlertDialog.noConnectionAlert();
      return ApiResponse.error('No Internet connection');
    }
  }

  static Future getAPIRequest(String url, String accessToken) {
    if (accessToken != "") {
      return http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "*/*",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
          'Authorization': accessToken,
        },
      );
    } else {
      return http.get(
        Uri.parse(url),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      );
    }
  }

  static Future<ApiResponse> patchApi(
      String url, String accessToken, Map body) async {
    var urlStr = Uri.parse(url.toString());
    try {
      final response = await http.patch(
        urlStr,
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'Authorization': accessToken,
        },
        body: jsonEncode(body),
      );

      var responseJson = _returnResponse(response);
      return ApiResponse.completed(responseJson);
    } on SocketException {
      CustomAlertDialog.noConnectionAlert();
      return ApiResponse.error('No Internet connection');
    } catch (e) {
      return ApiResponse.error('ApiResponse Error $e');
    }
  }

  static Future<ApiResponse> postApi(
      String url, String accessToken, Map body) async {
    var urlStr = Uri.parse(url.toString());

    try {
      final response = await http.post(
        urlStr,
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'Authorization': accessToken,
        },
        body: jsonEncode(body),
      );
      var responseJson = _returnResponse(response);

      return ApiResponse.completed(responseJson);
    } on SocketException {
      CustomAlertDialog.noConnectionAlert();
      return ApiResponse.error('No Internet connection');
    } catch (e) {
      return ApiResponse.error('ApiResponse Error $e');
    }
  }

  static Future<ApiResponse> loginPostApi(
      String url, String accessToken, Map body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'Authorization': accessToken,
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString('token', response.headers['accesstoken']!);
      }
      var responseJson = _returnResponse(response);

      return ApiResponse.completed(responseJson);
    } on SocketException {
      CustomAlertDialog.noConnectionAlert();
      return ApiResponse.error('No Internet connection');
    } catch (e) {
      return ApiResponse.error('ApiResponse Error $e');
    }
  }

  //Put Api Method
  static Future<ApiResponse> putAPI(
      String url, String accessToken, Map body) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'Authorization': accessToken,
        },
        body: jsonEncode(body),
      );
      var responseJson = _returnResponse(response);
      return ApiResponse.completed(responseJson);
    } on SocketException {
      CustomAlertDialog.noConnectionAlert();
      return ApiResponse.error('No Internet connection');
    } catch (e) {
      return ApiResponse.error('ApiResponse Error $e');
    }
  }

  //Delete with parameter Api Method
  static Future deleteAPI(String url, String accessToken) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "*/*",
          'Authorization': accessToken,
        },
      );
      var responseJson = _returnResponse(response);
      return ApiResponse.completed(responseJson);
    } on SocketException {
      CustomAlertDialog.noConnectionAlert();
      return ApiResponse.error('No Internet connection');
    } catch (e) {
      return ApiResponse.error('ApiResponse Error $e');
    }
  }

  //Delete with Body Api Method
  static Future deleteWithBodyAPI(String url, String accessToken, Map body) {
    final _url = Uri.parse(url);
    final request = http.Request("DELETE", _url);
    request.headers.addAll(
      <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "*/*",
        'connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        'Authorization': accessToken,
      },
    );
    request.body = jsonEncode(body);
    return request.send();
  }

  //Uploading a image or video api method
  /* static Future uploadImageAPI(
      String url, File _image, int userId, String accessToken) async {
    try {

      File file = File(_image.path!);
      var response = http.MultipartRequest('POST', Uri.parse(url));
      Map<String, String> headers = {
        "content-type": "application/x-tar",
        'Authorization': accessToken,
      };
      response.headers.addAll(headers);
      response.fields["userId"] = userId.toString();
      response.files.add(
        http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: _image.name,
        ),
      );
      var res = await response.send();
      return res;
    } catch (e) {
      return null;
    }
  }*/
}
