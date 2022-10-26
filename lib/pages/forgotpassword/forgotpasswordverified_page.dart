import 'package:shokuni_customer/pages/pages.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

import '../../main.dart';

class ForgotPasswordVerify extends StatefulWidget {
  static const String routeName = '/forgotPasswordVerify';
  const ForgotPasswordVerify({Key? key}) : super(key: key);

  @override
  _ForgotPasswordVerifyState createState() => _ForgotPasswordVerifyState();
}

class _ForgotPasswordVerifyState extends State<ForgotPasswordVerify> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BackGroundImageWidget(
      imagepath: 'assets/images/background.png',
      body: Scaffold(
        backgroundColor: frostColor.withOpacity(0.6),
        body: SingleChildScrollView(child: body()),
      ),
    );
  }

  Widget body() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shokuniTitle(),
          babertitle(),
          verify(),
          Center(
            child: CustomText(
              margin: const EdgeInsets.only(top: 10),
              style: lightBlueTextStyle,
              txtName: forgotPassText,
              align: TextAlign.start,
            ),
          ),
          Center(
            child: CustomText(
              margin: const EdgeInsets.only(top: 2),
              style: lightBlueTextStyle,
              txtName: forgotPass1Text,
              align: TextAlign.center,
            ),
          ),
          loginBtn(),
        ],
      ),
    );
  }

  Widget shokuniTitle() {
    return CustomText(
        txtName: shokuniText,
        margin: const EdgeInsets.only(left: 30, top: 130),
        style: titleBoldTextStyle,
        align: TextAlign.start);
  }

  Widget babertitle() {
    return CustomText(
        txtName: barberText,
        margin: const EdgeInsets.only(left: 30),
        style: titleSemiBoldTextStyle,
        align: TextAlign.start);
  }

  Widget verify() {
    return Center(
      child: CustomText(
          txtName: forgotPasswordCapsText,
          margin: const EdgeInsets.only(left: 30, top: 50),
          style: mediumBlueTitleTextStyle,
          align: TextAlign.start),
    );
  }

  Widget loginBtn() {
    return Center(
      child: CustomBtn(
        primaryColor: roseColor,
        surfaceColor: roseColor,
        buttonTestStyle: whiteBtnTextStyle,
        buttonName: loginText,
        buttonMargin: const EdgeInsets.only(top: 40),
        buttonPadding: EdgeInsets.zero,
        buttonHeight: 50,
        buttonWidth: 150,
        buttonCornerRadius: 0,
        buttonBorderColor: roseColor,
        onPressed: () {
          navigatorKey.currentState!
              .pushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);
        },
        textScaleFactor: 1.0,
      ),
    );
  }
}
