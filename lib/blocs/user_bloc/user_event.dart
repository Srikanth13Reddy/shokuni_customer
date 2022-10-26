import 'package:equatable/equatable.dart';
import 'package:shokuni_customer/models/model.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class LoginClickEvent extends UserEvent {
  final String username;
  final String password;

  const LoginClickEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginClickEvent { username: $username, password: $password }';
}

class ForgotClickEvent extends UserEvent {
  final ForgotPasswordRequest forgotpassworddetails;

  const ForgotClickEvent({required this.forgotpassworddetails});

  @override
  List<Object> get props => [forgotpassworddetails];

  @override
  String toString() =>
      'ForgotClickEvent { forgotpassworddetails: $forgotpassworddetails }';
}

class RegisterClickEvent extends UserEvent {
  final RegisterRequest registerdetails;

  const RegisterClickEvent({required this.registerdetails});

  @override
  List<Object> get props => [registerdetails];

  @override
  String toString() =>
      'RegisterClickEvent { registerdetails: $registerdetails }';
}

class PaymentClickEvent extends UserEvent {
  final CardRequest carddetails;

  const PaymentClickEvent({
    required this.carddetails,
  });

  @override
  List<Object> get props => [carddetails];

  @override
  String toString() => 'PaymentClickEvent { carddetails: $carddetails }';
}

class CardDetailsClickEvent extends UserEvent {
  const CardDetailsClickEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'CardDetailsClickEvent ';
}
