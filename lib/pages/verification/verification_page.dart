import 'dart:ui';

import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

class VerificationPage extends StatefulWidget {
  static const String routeName = '/verification';
  const VerificationPage({Key? key}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: Stack(fit: StackFit.expand, children: [
          Image.asset('assets/images/background.png', fit: BoxFit.cover),
          ClipRRect(

              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: frostColor.withOpacity(0.5),
                    alignment: Alignment.center,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: body(),
                    ),
                  )))
        ]));
  }

  Widget body() {
    return LoadingIndicator(
      isLoading: _isLoading,
      widget: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(

          children: [
            shokuniTitle(),
            babertitle(),
            verify(),
            CustomText(
              margin: const EdgeInsets.only(top: 10, left: 25),
              style: lightBlueTextStyle,
              txtName: verificationText,
              align: TextAlign.start,
            ),
            CustomText(
              margin: const EdgeInsets.only(top: 2, left: 120),
              style: lightBlueTextStyle,
              txtName: verification1Text,
              align: TextAlign.center,
            ),
            _buildEmail(),
            const SizedBox(
              height: 10,
            ),
            resendtext(),
            registerBtn(),
          ],
        ),
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
    return CustomText(
        txtName: verifyText,
        margin: const EdgeInsets.only(left: 30, top: 50),
        style: titlesTextStyle,
        align: TextAlign.start);
  }

  final _verifyController = TextEditingController();
  final _verifyFocus = FocusNode();

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _verifyController,
        validator: (value) => emailOtpValidator(value!),
        focusNode: _verifyFocus,
        decoration: InputDecoration(
          hintText: verifyCodeText,
          fillColor: const Color(0xFFF4F6F9),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  Widget resendtext() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
        child: RichText(
          text: const TextSpan(
              text: 'Didn\'t recieve a code?',
              style: TextStyle(color: riverBedBlueColor, fontSize: 20),
              children: <TextSpan>[
                TextSpan(
                    text: '   Resend! ',
                    style: TextStyle(color: roseColor, fontSize: 20))
              ]),
        ),
      ),
    );
  }

  Widget registerBtn() {
    return Center(
      child: CustomBtn(
        primaryColor: roseColor,
        surfaceColor: roseColor,
        buttonTestStyle: whiteBtnTextStyle,
        buttonName: verifyText,
        buttonMargin: const EdgeInsets.only(top: 30),
        buttonPadding: EdgeInsets.zero,
        buttonHeight: 40,
        buttonWidth: 150,
        buttonCornerRadius: 0,
        buttonBorderColor: roseColor,
        onPressed: () {
          if (_formKey.currentState!.validate()) {

          }
        },
        textScaleFactor: 1.0,
      ),
    );
  }

}
