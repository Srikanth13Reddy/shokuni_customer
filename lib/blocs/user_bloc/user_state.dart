import 'package:equatable/equatable.dart';
import 'package:shokuni_customer/models/model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserFailure extends UserState {
  final String error;

  const UserFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' LoginFailure { error: $error }';
}

class UserLoaded extends UserState {
  final LoginResponse users;
  final RegisterResponse user;

  const UserLoaded({required this.users, required this.user}) : super();

  @override
  String toString() => 'UserLoaded $users $user';
}

class CardsDetailsLoaded extends UserState {
  final CardsDetailsResponse details;

  const CardsDetailsLoaded({required this.details}) : super();

  @override
  String toString() => 'CardsDetailsLoaded $details ';
}
