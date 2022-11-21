import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/cache/local_storage.dart';
import 'package:shokuni_customer/pages/pages.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final UserBloc _userBloc = UserBloc();
  final _emailController = TextEditingController(text: "srikanthy+001@apptomate.co");
  //text: "sourabh@webworldexpertsindia.com"
  //text: "shokunicustomer@gmail.com"
  final _passwordController = TextEditingController(text: "637b2f573aa44");
  //text: "5bf4f557bebc9"
  //text: "62fb98344e8e1"
  final _emailFocus = FocusNode();

  final _passwordFocus = FocusNode();
  bool hidepassword = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
  }

  String _notificationTokenId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deviceinfo();

    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((String? token) async {
      assert(token != null);
      if (token != null) {
        _notificationTokenId = token;
        print("_notificationTokenId $_notificationTokenId");
        final sharedPref = await LocalStorageService.getInstance();
        sharedPref!.setString('fcm_token', _notificationTokenId);
      } else {}
    });
  }

  Future<String?> deviceinfo() async {
    final sharedPref = await LocalStorageService.getInstance();

    var deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isIOS) {
        var iosDeviceInfo = await deviceInfo.iosInfo;
        sharedPref!
            .setString('iosdevice_tokens', iosDeviceInfo.identifierForVendor!);

        return iosDeviceInfo.identifierForVendor;
      } else {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        sharedPref!
            .setString('androiddevice_token', androidDeviceInfo.androidId!);

        return androidDeviceInfo.androidId;
      }
    } catch (e) {
      print('what is error in catch device token: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundImageWidget(
      imagepath: 'assets/images/background.png',
      body: Scaffold(
        backgroundColor: frostColor.withOpacity(0.6),
        body: BlocBuilder<UserBloc, UserState>(
            bloc: _userBloc,
            builder: (context, state) {
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
        children: [
          shokuniTitle(),
          babertitle(),
          _buildEmail(),
          _buildPassword(),
          buttons(),
          forgotPasswordBtn(),
        ],
      ),
    );
  }

  Widget shokuniTitle() {
    return CustomText(
        txtName: shokuniText,
        margin: const EdgeInsets.only(left: 25, top: 150),
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

  Widget _buildEmail() {
    return CustomTextFormFieldWidget(
      margin: const EdgeInsets.only(left: 25, top: 50, right: 25),
      hintText: userText,
      onFieldTap: () {},
      obscureText: false,
      textInputType: TextInputType.emailAddress,
      actionKeyboard: TextInputAction.done,
      controller: _emailController,
      focusNode: _emailFocus,
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

  Widget _buildPassword() {
    return Stack(
      children: <Widget>[
        CustomTextFormFieldWidget(
          margin: const EdgeInsets.only(left: 25, top: 20, right: 25),
          hintText: passwordText,
          onFieldTap: () {},
          obscureText: hidepassword,
          textInputType: TextInputType.emailAddress,
          actionKeyboard: TextInputAction.done,
          controller: _passwordController,
          focusNode: _passwordFocus,
          onSubmitField: () {},
          filledColor: whiteColor,
          isFilled: true,
          prefixIcon: const Padding(
            padding: EdgeInsets.all(10),
            child: ImageIcon(
              AssetImage("assets/images/password.png"),
              color: Colors.black26,
            ),
          ),
          validator: (value) => passwordValidator(value),
          textStyle: textBoxTextStyle,
          enabled: false,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            padding: const EdgeInsets.only(right: 35, top: 33),
            onPressed: () => showHide(),
            icon: Icon(
              hidepassword ? Icons.visibility_off : Icons.visibility,
              color: greyColor,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  showHide() {
    setState(() {
      hidepassword = !hidepassword;
    });
  }

  Widget buttons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: loginInBtn()),
        Expanded(child: registerBtn()),
      ],
    );
  }

  Widget loginInBtn() {
    return CustomBtn(
      primaryColor: roseColor,
      surfaceColor: roseColor,
      buttonTestStyle: whiteBtnTextStyle,
      buttonName: loginText,
      buttonMargin: const EdgeInsets.only(top: 40, right: 10, left: 25),
      buttonPadding: EdgeInsets.zero,
      buttonHeight: 50,
      buttonWidth: double.infinity,
      buttonCornerRadius: 0,
      buttonBorderColor: roseColor,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          FocusScope.of(context).requestFocus(FocusNode());

          _userBloc.add(
            LoginClickEvent(
              username: _emailController.text,
              password: _passwordController.text,
            ),
          );
          // _userBloc.add(VerifyClickEvent());
        }
      },
      textScaleFactor: 1.0,
    );
  }

  Widget registerBtn() {
    return CustomBtn(
      primaryColor: roseColor,
      surfaceColor: roseColor,
      buttonTestStyle: whiteBtnTextStyle,
      buttonName: registerText,
      buttonMargin: const EdgeInsets.only(top: 40, right: 25, left: 10),
      buttonPadding: EdgeInsets.zero,
      buttonHeight: 50,
      buttonWidth: double.infinity,
      buttonCornerRadius: 0,
      buttonBorderColor: roseColor,
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        navigatorKey.currentState!.pushNamed(RegisterPage.routeName);
      },
      textScaleFactor: 1.0,
    );
  }

  Widget forgotPasswordBtn() {
    return Center(
      child: CustomTextBtn(
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          navigatorKey.currentState!.pushNamed(ForgotPasswordPage.routeName);
        },
        txtName: forgotPasswordText,
        btnTestStyle: roseTextStyle,
        txtAlign: Alignment.center,
        margin: const EdgeInsets.only(top: 20),
      ),
    );
  }
}
