class ChangePasswordRequest {
  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  ChangePasswordRequest(
      {this.oldPassword, this.newPassword, this.confirmPassword});

  ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    oldPassword = json['old_password'];
    newPassword = json['new_password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['old_password'] = oldPassword;
    data['new_password'] = newPassword;
    data['confirm_password'] = confirmPassword;
    return data;
  }
}
