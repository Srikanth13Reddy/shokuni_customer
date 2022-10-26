import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/repository/customer_repository.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository customerRepository = CustomerRepository();

  CustomerBloc() : super(CustomerInitial()) {
    on<JoinQueueClickEvent>(_onJoinQueue);
    on<AlreadyinQueueClickEvent>(_onAlreadyinQueue);
    on<NearByShopClickEvent>(_onNearByShop);
    on<HistoryClickEvent>(_onHistory);
    on<GetUserClickEvent>(_ongetUser);
    on<UpdateUserClickEvent>(_ongetUserUpadte);
    on<ChangePasswordClickEvent>(_onChangePassword);
    on<LeaveQueueClickEvent>(_onLeaveQueue);
    on<GetNotificationClickEvent>(_ongetNotification);
    on<GetNotificationReadClickEvent>(_ongetNotificationRead);
  }

  void _onJoinQueue(
      JoinQueueClickEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      bool result = await customerRepository.joinqueue(
          joinQueueDetails: event.joinQueueDetails);
      if (result) {
        final details = await customerRepository.alreadyinqueue();
        emit(CustomeralreadyLoaded(queueDetails: details!));
      } else {
        emit(CustomerInitial());
      }
    } catch (error) {
      emit(CustomerFailure(error: error.toString()));
    }
  }

  void _onAlreadyinQueue(
      AlreadyinQueueClickEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      final details = await customerRepository.alreadyinqueue();
      emit(CustomeralreadyLoaded(queueDetails: details!));
    } catch (error) {
      emit(CustomerFailure(error: error.toString()));
    }
  }

  void _onNearByShop(
      NearByShopClickEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      var users = await customerRepository.nearbyshop(event.lat,event.lang);
      emit(CustomerNearByShopLoaded(users: users!));
    } catch (error) {
      emit(CustomerFailure(error: error.toString()));
    }
  }

  void _onHistory(HistoryClickEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      final history = await customerRepository.history();
      emit(CustomerHistoryLoaded(historydetail: history!));
    } catch (error) {
      emit(CustomerFailure(error: error.toString()));
    }
  }

  void _ongetUser(GetUserClickEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      final userdetail = await customerRepository.customerdetails();
      emit(CustomerdetailLoaded(userdetail: userdetail!));
    } catch (error) {
      emit(CustomerFailure(error: error.toString()));
    }
  }

  void _ongetUserUpadte(
      UpdateUserClickEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      await customerRepository.profileupdate(
          userUpdateDetails: event.userUpdateDetails);
      emit(CustomerInitial());
    } catch (error) {
      emit(CustomerFailure(error: error.toString()));
    }
  }

  void _onChangePassword(
      ChangePasswordClickEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      await customerRepository.changepassword(
          changepassword: event.changepassword);
      emit(CustomerInitial());
    } catch (error) {
      emit(CustomerFailure(error: error.toString()));
    }
  }

  void _onLeaveQueue(
      LeaveQueueClickEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      bool result =
          await customerRepository.leaveQueue(leaveQueue: event.leaveQueue);
      if (result) {
        final details = await customerRepository.alreadyinqueue();

        emit(CustomeralreadyLoaded(
          queueDetails: details!,
        ));
      } else {
        emit(CustomerInitial());
      }
    } catch (error) {
      emit(CustomerFailure(error: error.toString()));
    }
  }

  void _ongetNotification(
      GetNotificationClickEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      final notification = await customerRepository.notification();
      emit(CustomerNotificationLoaded(notify: notification!));
    } catch (error) {
      emit(CustomerFailure(error: error.toString()));
    }
  }

  void _ongetNotificationRead(
      GetNotificationReadClickEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      await customerRepository.notificationread(notifyreq: event.notifyread);
      emit(CustomerInitial());
    } catch (error) {
      emit(CustomerFailure(error: error.toString()));
    }
  }
}
