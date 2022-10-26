import 'package:flutter/material.dart';
 import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shokuni_customer/main.dart';
import 'package:shokuni_customer/pages/pages.dart';

class CustomAlertDialog {
  static Future<void> showToast(String messages) async {
    Fluttertoast.showToast(
      msg: messages,
      backgroundColor: Colors.black87,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 12,
    );
  }

  static Future<void> sessionExpired() async {
    var alert = AlertDialog(
      elevation: 6,
      title: const Text("Session Expired"),
      content: const Text("Please login again"),
      actions: <Widget>[
        TextButton(
            onPressed: () async {
              final sharedPref = await SharedPreferences.getInstance();
              sharedPref.clear();
              navigatorKey.currentState!.pushNamedAndRemoveUntil(
                  LoginPage.routeName, (route) => false);
            },
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );
    showDialog(
        barrierDismissible: false,
        context: navigatorKey.currentContext!,
        builder: (_) {
          return alert;
        }).then((val) {
      return true;
    });
  }

  static Future<void> noConnectionAlert() async {
    var alert = AlertDialog(
      elevation: 6,
      title: const Text("Unable to connect"),
      content: const Text("Please Check Internet Connection"),
      actions: <Widget>[
        TextButton(
            onPressed: () async {
              final sharedPref = await SharedPreferences.getInstance();
              sharedPref.clear();
              /*navigatorKey.currentState!.pushNamedAndRemoveUntil(
                  LoginPage.routeName, (route) => false);*/
            },
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );
    showDialog(
        barrierDismissible: false,
        context: navigatorKey.currentContext!,
        builder: (_) {
          return alert;
        }).then((val) {
      return true;
    });
  }

  static Future<void> customAlert(String title, String msg) async {
    var alert = AlertDialog(
      elevation: 6,
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        TextButton(
            onPressed: () async {
              // final sharedPref = await SharedPreferences.getInstance();
              //sharedPref.clear();
              navigatorKey.currentState!.pop();
            },
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );
    showDialog(
        barrierDismissible: false,
        context: navigatorKey.currentContext!,
        builder: (_) {
          return alert;
        }).then((val) {
      return true;
    });
  }
}
