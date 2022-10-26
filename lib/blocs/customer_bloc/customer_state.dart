import 'package:equatable/equatable.dart';
import 'package:shokuni_customer/models/model.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerFailure extends CustomerState {
  final String error;

  const CustomerFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' CustomerFailure { error: $error }';
}

class CustomerNearByShopLoaded extends CustomerState {
  final NearByShopData users;

  const CustomerNearByShopLoaded({required this.users}) : super();
  @override
  List<Object> get props => [users];

  @override
  String toString() => 'CustomerNearByShopLoaded $users';
}

class CustomeralreadyLoaded extends CustomerState {
  final AlreadyInQueueResponse queueDetails;

  const CustomeralreadyLoaded({
    required this.queueDetails,
  }) : super();
  @override
  List<Object> get props => [
        queueDetails,
      ];

  @override
  String toString() => 'CustomeralreadyLoaded $queueDetails ';
}

class CustomerdetailLoaded extends CustomerState {
  final CustomerDetail userdetail;

  const CustomerdetailLoaded({required this.userdetail}) : super();
  @override
  List<Object> get props => [userdetail];

  @override
  String toString() => 'CustomerdetailLoaded $userdetail';
}

class CustomerHistoryLoaded extends CustomerState {
  final HistoryResponse historydetail;

  const CustomerHistoryLoaded({
    required this.historydetail,
  }) : super();
  @override
  List<Object> get props => [
        historydetail,
      ];

  @override
  String toString() => 'CustomerdetailLoaded $historydetail';
}

class CustomerjoinQueueLoaded extends CustomerState {
  final JoinQueueData usersjoin;

  const CustomerjoinQueueLoaded({required this.usersjoin}) : super();
  @override
  List<Object> get props => [usersjoin];

  @override
  String toString() => 'CustomerjoinQueueLoaded $usersjoin';
}

class CustomerNotificationLoaded extends CustomerState {
  final NotificationResponse notify;

  const CustomerNotificationLoaded({required this.notify}) : super();
  @override
  List<Object> get props => [notify];

  @override
  String toString() => 'CustomerNotificationLoaded $notify';
}
