import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/models/model.dart';
import 'package:shokuni_customer/services/services.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

import '../../main.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String routeName = '/forgotPassword';
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  UserBloc userBloc = UserBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _forgotpasswordController.dispose();
    _forgotpasswordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundImageWidget(
      imagepath: 'assets/images/background.png',
      body: Scaffold(
        backgroundColor: frostColor.withOpacity(0.6),
        body: BlocBuilder<UserBloc, UserState>(
          bloc: userBloc,
          builder: (context, state) {
            return LoadingIndicator(
              isLoading: state is UserLoading ? true : false,
              widget: body(),
            );
          },
        ),
      ),
    );
  }

  Widget body() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: ListView(
        children: [
          shokuniTitle(),
          babertitle(),
          Center(
            child: CustomText(
              margin: const EdgeInsets.only(top: 2),
              style: lightBlueTextStyle,
              txtName: forgotEnterYourEmailBelowText,
              align: TextAlign.center,
            ),
          ),
          _buildEmail(),
          buttons(),
        ],
      ),
    );
  }

  Widget shokuniTitle() {
    return CustomText(
        txtName: shokuniText,
        margin: const EdgeInsets.only(left: 25, top: 130),
        style: GoogleFonts.workSans(
          fontWeight: FontWeight.bold,
          fontSize: 80,
          color: riverBedBlueColor,
        ),
        align: TextAlign.start);
  }

  Widget babertitle() {
    return CustomText(
        txtName: barberText,
        margin: const EdgeInsets.only(left: 25),
        style: GoogleFonts.workSans(
          fontWeight: FontWeight.normal,
          fontSize: 40,
          color: roseColor,
        ),
        align: TextAlign.start);
  }

  Widget verifyTitle() {
    return Center(
      child: CustomText(
          txtName: forgotPasswordCapsText,
          margin: const EdgeInsets.only(top: 50),
          style: GoogleFonts.workSans(
            fontWeight: FontWeight.w600,
            fontSize: 30,
            color: blueZodiacColor,
          ),
          align: TextAlign.start),
    );
  }

  final _forgotpasswordController = TextEditingController();
  final _forgotpasswordFocus = FocusNode();

  Widget _buildEmail() {
    return CustomTextFormFieldWidget(
      margin: const EdgeInsets.only(left: 25, top: 20, right: 25),
      hintText: emailText,
      onFieldTap: () {},
      obscureText: false,
      textInputType: TextInputType.emailAddress,
      actionKeyboard: TextInputAction.done,
      controller: _forgotpasswordController,
      focusNode: _forgotpasswordFocus,
      onSubmitField: () {},
      filledColor: whiteColor,
      isFilled: true,
      prefixIcon: const Padding(
        padding: EdgeInsets.all(10),
        child: ImageIcon(
          AssetImage("assets/images/user.png"),
          color: Colors.black26,
        ),
      ),
      validator: (value) => validateEmailField(value),
      textStyle: textBoxTextStyle,
      enabled: false,
    );
  }

  Widget buttons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: cancelBtn()),
        Expanded(child: submitBtn()),
      ],
    );
  }

  Widget cancelBtn() {
    return CustomTextBtn(
      onPressed: () {
        navigatorKey.currentState!.pop();
      },
      txtName: cancelText,
      btnTestStyle: roseTextStyle,
      txtAlign: Alignment.center,
      margin: const EdgeInsets.only(top: 35, left: 25),
    );
  }

  Widget submitBtn() {
    return CustomBtn(
      primaryColor: roseColor,
      surfaceColor: roseColor,
      buttonTestStyle: whiteBtnTextStyle,
      buttonName: submitText,
      buttonMargin: const EdgeInsets.only(top: 45, right: 25),
      buttonPadding: EdgeInsets.zero,
      buttonHeight: 50,
      buttonWidth: double.infinity,
      buttonCornerRadius: 0,
      buttonBorderColor: roseColor,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ForgotPasswordRequest forgotpassword = ForgotPasswordRequest(
              email: _forgotpasswordController.text,
              hostname: forgetpasswordhostname);
          userBloc.add(ForgotClickEvent(forgotpassworddetails: forgotpassword));
        }
      },
      textScaleFactor: 1.0,
    );
  }
}
