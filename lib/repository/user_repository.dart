import 'dart:io';

import 'package:shokuni_customer/cache/local_storage.dart';
import 'package:shokuni_customer/main.dart';
import 'package:shokuni_customer/models/model.dart';
import 'package:shokuni_customer/pages/pages.dart';
import 'package:shokuni_customer/services/services.dart';
import 'package:shokuni_customer/utils/utils.dart';

class UserRepository {
  Future<String> authenticate({
    required String username,
    required String password,
  }) async {
    try {
      String fcmtoken = await LocalStorageService.getfcm();
      String androiddevicetoken =
          await LocalStorageService.getandroiddevicetoken();
      String iosdevicetoken = await LocalStorageService.getiosdevicetoken();
      var body = LoginRequest(
          username: username,
          password: password,
          clientId: clientId,
          clientSecret: clientSecret,
          grantType: grantType,
          deviceToken: Platform.isAndroid ? androiddevicetoken : iosdevicetoken,
          deviceType: Platform.isAndroid ? "android" : "iphone",
          fcmToken: fcmtoken,
          role: "consumer");
      final response = await ApiBaseHelper.postApi(loginUrl, '', body.toJson());

      if (response.status == Status.COMPLETED) {
        LoginResponse loginres = LoginResponse.fromJson(response.data);

        final prefs = await LocalStorageService.getInstance();
        if (loginres.status == true) {
          prefs!.setBool("isUserLoggedIn", true);
          prefs.setString(
              "access_token", 'Bearer ${loginres.data!.accessToken!}');
          prefs.setString(
              "refresh_token", 'Bearer ${loginres.data!.refreshToken!}');

          prefs.setString("userId", loginres.data!.user!.id.toString());
          prefs.setString("userName", loginres.data!.user!.name!);
          CustomAlertDialog.showToast(loginres.message!);
          navigatorKey.currentState!.pushNamed(HomePage.routeName);
        } else {
          prefs!.setBool("isUserLoggedIn", false);
          CustomAlertDialog.customAlert("Login Failed", loginres.message!);
        }
      }
      return 'authenticate $response';
    } catch (e) {
      return 'authenticate error $e';
    }
  }

  Future<String> forgot({required ForgotPasswordRequest forgotreq}) async {
    try {
      final response = await ApiBaseHelper.postApi(
          forgotpasswordUrl, '', forgotreq.toJson());

      if (response.status == Status.COMPLETED) {
        ForgotPasswordResponse forgotres =
            ForgotPasswordResponse.fromJson(response.data);
        if (forgotres.status == true) {
          navigatorKey.currentState!.pushNamed(ForgotPasswordVerify.routeName);
        } else {
          CustomAlertDialog.customAlert(
              "Invalid Credentials", forgotres.message!);
        }
      }
      return 'authenticate $response';
    } catch (e) {
      return 'authenticate error $e';
    }
  }

  Future<String> register({required RegisterRequest registerreq}) async {
    try {
      final response =
          await ApiBaseHelper.postApi(registerUrl, '', registerreq.toJson());

      final prefs = await LocalStorageService.getInstance();
      if (response.status == Status.COMPLETED) {
        RegisterResponse registerres = RegisterResponse.fromJson(response.data);

        if (registerres.status == true) {
          prefs!
              .setString("user_id", registerres.data!.user!.userId.toString());
          prefs.setBool("isUserLoggedIn", true);
          CustomAlertDialog.showToast(registerres.message!);
          navigatorKey.currentState!
              .pushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);
        } else {
          prefs!.setBool("isUserLoggedIn", false);
          CustomAlertDialog.customAlert(
              "Invalid Credentials", registerres.message!);
        }
      }
      return 'authenticate $response';
    } catch (e) {
      return 'authenticate error $e';
    }
  }

  Future<String> payment({
    String? accessToken,
    required CardRequest cardreq,
  }) async {
    try {
      final prefs = await LocalStorageService.getInstance();
      accessToken = prefs!.getString("access_token");
      final response =
          await ApiBaseHelper.postApi(cardUrl, accessToken!, cardreq.toJson());

      if (response.status == Status.COMPLETED) {
        CardResponse cardres = CardResponse.fromJson(response.data);

        if (cardres.status == true) {
          carddetails();
          navigatorKey.currentState!.pop();
        } else {
          CustomAlertDialog.customAlert(
              "Please Enter Correct Field", cardres.message!);
        }
      }
      return 'authenticate $response';
    } catch (e) {
      return 'authenticate error $e';
    }
  }

  Future<CardsDetailsResponse?> carddetails() async {
    try {
      String customerid = await LocalStorageService.getId();
      CardsDetailsRequest cardsdetailsreq =
          CardsDetailsRequest(customerId: int.parse(customerid));
      String accessToken = await LocalStorageService.getToken();
      final response = await ApiBaseHelper.postApi(
          carddeatislUrl, accessToken, cardsdetailsreq.toJson());
      if (response.status == Status.COMPLETED) {
        CardsDetailsResponse cardsdetailsres =
            CardsDetailsResponse.fromJson(response.data);
        if (cardsdetailsres.status == true) {
          return cardsdetailsres;
        } else {
          CustomAlertDialog.customAlert(
              "Card Details Failed", cardsdetailsres.message!);
        }
      }
    } catch (e) {
      return null;
    }
  }
}
