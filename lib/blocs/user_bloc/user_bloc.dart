import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository = UserRepository();

  UserBloc() : super(UserInitial()) {
    on<LoginClickEvent>(_onLogin);
    on<ForgotClickEvent>(_onForgot);
    on<RegisterClickEvent>(_onRegister);
    on<PaymentClickEvent>(_onPayment);
    on<CardDetailsClickEvent>(_onCardDetails);
  }

  void _onLogin(LoginClickEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.authenticate(
        username: event.username,
        password: event.password,
      );
      emit(UserInitial());
    } catch (error) {
      emit(UserFailure(error: error.toString()));
    }
  }

  void _onForgot(ForgotClickEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.forgot(
        forgotreq: event.forgotpassworddetails,
      );
      emit(UserInitial());
    } catch (error) {
      emit(UserFailure(error: error.toString()));
    }
  }

  void _onRegister(RegisterClickEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.register(
        registerreq: event.registerdetails,
      );
      emit(UserInitial());
    } catch (error) {
      emit(UserFailure(error: error.toString()));
    }
  }

  void _onPayment(PaymentClickEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.payment(cardreq: event.carddetails);
      emit(UserInitial());
    } catch (error) {
      emit(UserFailure(error: error.toString()));
    }
  }

  void _onCardDetails(
      CardDetailsClickEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final carddeatisl = await userRepository.carddetails();
      emit(CardsDetailsLoaded(details: carddeatisl!));
    } catch (error) {
      emit(UserFailure(error: error.toString()));
    }
  }
}
