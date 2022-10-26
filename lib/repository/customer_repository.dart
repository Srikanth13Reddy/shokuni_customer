import 'package:shokuni_customer/cache/local_storage.dart';
import 'package:shokuni_customer/models/model.dart';
import 'package:shokuni_customer/services/services.dart';
import 'package:shokuni_customer/utils/utils.dart';

class CustomerRepository {
  Future<bool> joinqueue({required JoinQueueRequest joinQueueDetails}) async {
    try {
      String accessToken = await LocalStorageService.getToken();
      final response = await ApiBaseHelper.postApi(
          joinqueueUrl, accessToken, joinQueueDetails.toJson());
      bool result = false;
      if (response.status == Status.COMPLETED) {
        JoinQueueResponse joinqueueres =
            JoinQueueResponse.fromJson(response.data);
        result = joinqueueres.status!;

        if (joinqueueres.status == false) {
          CustomAlertDialog.customAlert(
              "Join Queue Failed", joinqueueres.message!);
        }
      }
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<AlreadyInQueueResponse?> alreadyinqueue() async {
    try {
      String customerid = await LocalStorageService.getId();
      AlreadyInQueueRequest alreadyreq =
          AlreadyInQueueRequest(customerId: customerid.toString());

      String accessToken = await LocalStorageService.getToken();

      final response = await ApiBaseHelper.postApi(
          alreadyinqueueUrl, accessToken, alreadyreq.toJson());

      if (response.status == Status.COMPLETED) {
        AlreadyInQueueResponse alreadyres =
            AlreadyInQueueResponse.fromJson(response.data);

        return alreadyres;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<NearByShopData?> nearbyshop(lat,lang) async {
    try {
      NearByShopRequest shopreq = NearByShopRequest(
          distance: "80.09758508644862", lat: lat, lng: lang);
      String accessToken = await LocalStorageService.getToken();
      final response = await ApiBaseHelper.postApi(
          nearbyshopUrl, accessToken, shopreq.toJson());
      if (response.status == Status.COMPLETED) {
        NearByShopResponse shopreq = NearByShopResponse.fromJson(response.data);
        if (shopreq.status == true) {
          return shopreq.data;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }



  Future<HistoryResponse?> history() async {
    try {
      String accessToken = await LocalStorageService.getToken();
      final response = await ApiBaseHelper.getAPI(historyUrl, accessToken);

      if (response.status == Status.COMPLETED) {
        HistoryResponse historyreq = HistoryResponse.fromJson(response.data);
        if (historyreq.status == true) {
          return historyreq;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String> profileupdate(
      {required UpdateUserRequest userUpdateDetails}) async {
    try {
      String accessToken = await LocalStorageService.getToken();
      final response = await ApiBaseHelper.putAPI(
          updateprofileUrl, accessToken, userUpdateDetails.toJson());

      if (response.status == Status.COMPLETED) {
        UpdateUserResponse updatereq =
            UpdateUserResponse.fromJson(response.data);

        if (updatereq.status == true) {
          final prefs = await LocalStorageService.getInstance();

          prefs!.setString("userName",
              userUpdateDetails.firstName! + " " + userUpdateDetails.lastName!);
          customerdetails();
          CustomAlertDialog.showToast("Profile Update Successfully");
          return updatereq.data.toString();
        } else {
          CustomAlertDialog.customAlert(
              "Profile Update Failed", updatereq.message!);
        }
      }
      return 'authenticate $response';
    } catch (e) {
      return 'authenticate error $e';
    }
  }

  Future<String> changepassword(
      {required ChangePasswordRequest changepassword}) async {
    try {
      String accessToken = await LocalStorageService.getToken();
      final response = await ApiBaseHelper.patchApi(
          changepasswordUrl, accessToken, changepassword.toJson());

      if (response.status == Status.COMPLETED) {
        ChangePasswordResponse changepasswordres =
            ChangePasswordResponse.fromJson(response.data);

        if (changepasswordres.status == true) {
          CustomAlertDialog.customAlert(
              "ChangePassword", changepasswordres.message!);
        } else {
          CustomAlertDialog.customAlert(
              "ChangePassword Failed", changepasswordres.message!);
        }
      }
      return 'authenticate $response';
    } catch (e) {
      return 'authenticate error $e';
    }
  }

  Future<CustomerDetail?> customerdetails() async {
    try {
      String accessToken = await LocalStorageService.getToken();

      final response =
          await ApiBaseHelper.getAPI(customerdetailUrl, accessToken);
      if (response.status == Status.COMPLETED) {
        CustomerResponse customeryreq =
            CustomerResponse.fromJson(response.data);
        if (customeryreq.status == true) {
          final prefs = await LocalStorageService.getInstance();
          prefs!.setString("customerId", customeryreq.data!.id.toString());
          return customeryreq.data;
        } else {
          CustomAlertDialog.customAlert(
              "Customer Details Failed", customeryreq.message!);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> leaveQueue({required LeaveQueueRequest leaveQueue}) async {
    try {
      String accessToken = await LocalStorageService.getToken();
      final response = await ApiBaseHelper.postApi(
          leavequeuUrl, accessToken, leaveQueue.toJson());
      bool result = false;
      if (response.status == Status.COMPLETED) {
        LeaveQueueResponse leaveQueures =
            LeaveQueueResponse.fromJson(response.data);
        result = leaveQueures.status!;

        if (leaveQueures.status == false) {
          CustomAlertDialog.customAlert(
              "Leave Queue Failed", leaveQueures.message!);
        } else {
          return result;
        }
      }
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<NotificationResponse?> notification() async {
    try {
      String accessToken = await LocalStorageService.getToken();
      String userid = await LocalStorageService.getId();
      final response =
          await ApiBaseHelper.getAPI(notificationUrl + userid, accessToken);
      if (response.status == Status.COMPLETED) {
        NotificationResponse notify =
            NotificationResponse.fromJson(response.data);
        if (notify.status == true) {
          return notify;
        } else {
          CustomAlertDialog.customAlert(
              "Notification Failed to Fetch", notify.message!);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<NotificationReadResponse?> notificationread(
      {required NotificationReadRequest notifyreq}) async {
    try {
      String accessToken = await LocalStorageService.getToken();

      final response = await ApiBaseHelper.postApi(
          notificationreadUrl, accessToken, notifyreq.toJson());

      if (response.status == Status.COMPLETED) {
        NotificationReadResponse notifyres =
            NotificationReadResponse.fromJson(response.data);
        if (notifyres.status == true) {
          notification();
          return notifyres;
        } else {
          CustomAlertDialog.customAlert("Notification", notifyres.message!);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
