import 'package:shokuni_customer/utils/constants.dart';

bool validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return true;
  } else {
    return false;
  }
}

String? validateEmailField(String value) {
  if (value == '') {
    return enterEmailText;
  } else {
    var isValid = validateEmail(value.trim());
    if (isValid) {
      return invalidEmailText;
    } else {
      return null;
    }
  }
}

passwordValidator(String password) {
  if (password.isEmpty) {
    return "Password required";
  }
  if (password.length < 6) {
    return "Password must be atleast 6 characters long";
  }
  if (password.length > 20) {
    return "Password must be less than 20 characters";
  }
  return null;
}

oldPassValidator(String password) {
  if (password.isEmpty) {
    return enterOldPasswordText;
  }
  return null;
}

newPassValidator(String password) {
  if (password.isEmpty) {
    return enterNewPasswordText;
  }
  return null;
}

phNoValidator(String number) {
  if (number.trim().isEmpty) {
    return enterPhNoText;
  } else {
    if (number.length == 10) {
      return null;
    } else {
      return enterPhNoMaxText;
    }
  }
}

confirmPasswordValidator(String confirm, String newPass) {
  if (confirm.isEmpty) return "Confirm password required";
  if (confirm != newPass) {
    return enterConfirmPasswordCorrectlyText;
  }
}

emailOtpValidator(String otp) {
  if (otp.isEmpty) {
    return enterEmailOtpText;
  } else {
    if (otp.length == 4) {
      return null;
    } else {
      return enterOtpLengthText;
    }
  }
}

commonValidator(String value, String errorTxt) {
  if (value.trim().isEmpty) {
    return errorTxt;
  }
  return null;
}
