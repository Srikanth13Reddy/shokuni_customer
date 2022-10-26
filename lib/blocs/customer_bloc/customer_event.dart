import 'package:equatable/equatable.dart';
import 'package:shokuni_customer/models/model.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();
  @override
  List<Object> get props => [];
}

class JoinQueueClickEvent extends CustomerEvent {
  final JoinQueueRequest joinQueueDetails;
  const JoinQueueClickEvent({required this.joinQueueDetails});

  @override
  List<Object> get props => [joinQueueDetails];

  @override
  String toString() => 'JoinQueueClickEvent';
}

class AlreadyinQueueClickEvent extends CustomerEvent {
  const AlreadyinQueueClickEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'AlreadyinQueueClickEvent';
}

class NearByShopClickEvent extends CustomerEvent {
  String lat;
  String lang;

  NearByShopClickEvent(this.lat, this.lang);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'NearByShopClickEvent';
}

class HistoryClickEvent extends CustomerEvent {
  const HistoryClickEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'HistoryClickEvent';
}

class UpdateUserClickEvent extends CustomerEvent {
  final UpdateUserRequest userUpdateDetails;
  const UpdateUserClickEvent({required this.userUpdateDetails});

  @override
  List<Object> get props => [userUpdateDetails];

  @override
  String toString() => 'UpdateUserClickEvent';
}

class ChangePasswordClickEvent extends CustomerEvent {
  final ChangePasswordRequest changepassword;
  const ChangePasswordClickEvent({required this.changepassword});

  @override
  List<Object> get props => [changepassword];

  @override
  String toString() => 'ChangePasswordClickEvent {$changepassword}';
}

class GetUserClickEvent extends CustomerEvent {
  const GetUserClickEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetUserClickEvent';
}

class LeaveQueueClickEvent extends CustomerEvent {
  final LeaveQueueRequest leaveQueue;
  const LeaveQueueClickEvent({required this.leaveQueue});

  @override
  List<Object> get props => [leaveQueue];

  @override
  String toString() => 'LeaveQueueClickEvent';
}

class GetNotificationClickEvent extends CustomerEvent {
  const GetNotificationClickEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetNotificationClickEvent';
}

class GetNotificationReadClickEvent extends CustomerEvent {
  final NotificationReadRequest notifyread;
  const GetNotificationReadClickEvent({required this.notifyread});

  @override
  List<Object> get props => [notifyread];

  @override
  String toString() => 'GetNotificationReadClickEvent  notifyread: $notifyread';
}
