import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/models/model.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

import '../../main.dart';

class PaymentPage extends StatefulWidget {
  static const String routeName = '/payment';
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final UserBloc _userBlocz = UserBloc();
  List<CardDetails>? card = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cardController.dispose();
    _cardFocus.dispose();
    _cardcsvController.dispose();
    _cardcsvFocus.dispose();
    _carddateController.dispose();
    _carddateFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundImageWidget(
      imagepath: 'assets/images/background.png',
      body: Scaffold(
        backgroundColor: frostColor.withOpacity(0.6),
        body: BlocBuilder<UserBloc, UserState>(
            bloc: _userBlocz,
            builder: (context, state) {
              if (state is CardsDetailsLoaded) {
                card!.addAll(state.details.data!);
              }
              return LoadingIndicator(
                isLoading: state is UserLoading ? true : false,
                widget: body(),
              );
            }),
      ),
    );
  }

  Widget body() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cancelBtn(),
          shokuniTitle(),
          babertitle(),
          paymentTitle(),
          CustomText(
            margin: const EdgeInsets.only(top: 10, left: 25),
            style: lightBlueTextStyle,
            txtName: paymentAccText,
            align: TextAlign.start,
          ),
          _buildCardName(),
          _buildCardNumber(),
          _buildCardcsv(),
          _buildCardExpiry(),
          continueBtn(),
          // buttons(),
          //  forgotPasswordBtn(),
        ],
      ),
    );
  }

  Widget cancelBtn()
  {
    return Align(alignment: Alignment.topLeft,
      child: IconButton(
        icon: const Icon(Icons.clear,color: riverBedBlueColor,),
        onPressed: () {
          navigatorKey.currentState!.pop();
        },
      ),
    );
  }

  Widget shokuniTitle() {
    return CustomText(
        txtName: shokuniText,
        margin: const EdgeInsets.only(left: 25, top: 45),
        style: titleBoldTextStyle,
        align: TextAlign.start);
  }

  Widget babertitle() {
    return CustomText(
        txtName: barberText,
        margin: const EdgeInsets.only(left: 25),
        style: titleSemiBoldTextStyle,
        align: TextAlign.start);
  }

  Widget paymentTitle() {
    return Center(
      child: CustomText(
          txtName: paymentText.toUpperCase(),
          margin: const EdgeInsets.only(top: 30),
          style: titlesTextStyle,
          align: TextAlign.start),
    );
  }

  final _cardnameController = TextEditingController();
  final _cardnameFocus = FocusNode();

  Widget _buildCardName() {
    return CustomTextFormFieldWidget(
      margin: const EdgeInsets.only(left: 25, top: 20, right: 25),
      hintText: cardNameText,
      onFieldTap: () {},
      obscureText: false,
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.done,
      controller: _cardnameController,
      focusNode: _cardnameFocus,
      onSubmitField: () {},
      filledColor: whiteColor,
      isFilled: true,
      validator: (value) => commonValidator(value, "Please Enter Name"),
      textStyle: textBoxTextStyle,
      enabled: false,
    );
  }

  final _cardController = TextEditingController();
  final _cardFocus = FocusNode();

  Widget _buildCardNumber() {
    return CustomTextFormFieldWidget(
      mask: '#### #### #### ####',
      margin: const EdgeInsets.only(left: 25, top: 20, right: 25),
      hintText: cardText,
      onFieldTap: () {},
      obscureText: false,
      textInputType: TextInputType.number,
      actionKeyboard: TextInputAction.done,
      controller: _cardController,
      focusNode: _cardFocus,
      onSubmitField: () {},
      filledColor: whiteColor,
      isFilled: true,
      validator: (value) => commonValidator(value, "Please Enter Number"),
      textStyle: textBoxTextStyle,
      enabled: false,
    );
  }

  final _cardcsvController = TextEditingController();
  final _cardcsvFocus = FocusNode();

  Widget _buildCardcsv() {
    return CustomTextFormFieldWidget(
      margin: const EdgeInsets.only(left: 25, top: 20, right: 25),
      hintText: cscText,
      onFieldTap: () {},
      obscureText: false,
      textInputType: TextInputType.number,
      actionKeyboard: TextInputAction.done,
      controller: _cardcsvController,
      focusNode: _cardcsvFocus,
      onSubmitField: () {},
      filledColor: whiteColor,
      isFilled: true,
      validator: (value) => commonValidator(value, "Please Enter CCV"),
      textStyle: textBoxTextStyle,
      enabled: false,
    );
  }

  final _carddateController = TextEditingController();
  final _carddateFocus = FocusNode();

  Widget _buildCardExpiry() {
    return CustomTextFormFieldWidget(
      mask: '##/##',
      margin: const EdgeInsets.only(left: 25, top: 20, right: 25),
      hintText: expiryText,
      onFieldTap: () {},
      obscureText: false,
      textInputType: TextInputType.phone,
      actionKeyboard: TextInputAction.done,
      controller: _carddateController,
      focusNode: _carddateFocus,
      onSubmitField: () {},
      filledColor: whiteColor,
      isFilled: true,
      validator: (value) =>
          commonValidator(value, "Please Enter Expiry Date MM/YY format"),
      textStyle: textBoxTextStyle,
      enabled: false,
    );
  }

  Widget continueBtn() {
    return Center(
      child: CustomBtn(
        primaryColor: roseColor,
        surfaceColor: roseColor,
        buttonTestStyle: whiteBtnTextStyle,
        buttonName: submitText,
        buttonMargin: const EdgeInsets.only(top: 30),
        buttonPadding: EdgeInsets.zero,
        buttonHeight: 50,
        buttonWidth: 150,
        buttonCornerRadius: 0,
        buttonBorderColor: roseColor,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            CardRequest cardreq = CardRequest(
                cardNumber: _cardController.text,
                cvv: _cardcsvController.text,
                expiryDate: _carddateController.text,
                nonce: _cardnameController.text);
            _userBlocz.add(
              PaymentClickEvent(carddetails: cardreq),
            );
            _userBlocz.add(const CardDetailsClickEvent());
          }
        },
        textScaleFactor: 1.0,
      ),
    );
  }
}
