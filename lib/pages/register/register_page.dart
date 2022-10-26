import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/models/model.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final UserBloc _userBlocs = UserBloc();
  bool valuefirst = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _emailFocus.dispose();
    _phoneController.dispose();
    _phoneFocus.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundImageWidget(
      imagepath: 'assets/images/background.png',
      body: Scaffold(
        backgroundColor: frostColor.withOpacity(0.6),
        body: BlocBuilder<UserBloc, UserState>(
          bloc: _userBlocs,
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
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: [
          shokuniTitle(),
          babertitle(),
          registertitle(),
          _buildfirstname(),
          _buildEmail(),
          _buildPhone(),
          _buildPassword(),
          _confirmPassword(),
          _checkbox(),
          registerBtn(),
        ],
      ),
    );
  }

  Widget shokuniTitle() {
    return CustomText(
        txtName: shokuniText,
        margin: const EdgeInsets.only(left: 25, top: 90),
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

  Widget registertitle() {
    return Center(
      child: CustomText(
          txtName: registerText,
          margin: const EdgeInsets.only(top: 30),
          style: titlesTextStyle,
          align: TextAlign.start),
    );
  }

  final TextEditingController _firstnameController = TextEditingController();
  final _firstnameFocus = FocusNode();

  Widget _buildfirstname() {
    return CustomTextFormFieldWidget(
      margin: const EdgeInsets.only(left: 25, top: 20, right: 25),
      hintText: firstNameText,
      onFieldTap: () {},
      obscureText: false,
      textInputType: TextInputType.text,
      actionKeyboard: TextInputAction.done,
      controller: _firstnameController,
      focusNode: _firstnameFocus,
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
      validator: (value) => commonValidator(
        value,
        enterNameText,
      ),
      textStyle: textBoxTextStyle,
      enabled: false,
    );
  }

  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();

  Widget _buildEmail() {
    return CustomTextFormFieldWidget(
      margin: const EdgeInsets.only(left: 25, top: 20, right: 25),
      hintText: emailText,
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

  final _phoneController = TextEditingController();
  final _phoneFocus = FocusNode();

  //var controller = MaskedTextController(mask: '(000) 000 0000');
  Widget _buildPhone() {
    final number = Padding(
      padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: blueZodiacColor,
        ),
        child: TextFormField(
          cursorColor: blueZodiacColor,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.sentences,
          focusNode: _phoneFocus,
          style: textBoxTextStyle,
          decoration: InputDecoration(
            fillColor: whiteColor,
            filled: true,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Text("+1"),
            ),
            hintText: phoneText,
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide:
                    const BorderSide(color: mediumGreyColor, width: 1.0)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide:
                    const BorderSide(color: mediumGreyColor, width: 1.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: const BorderSide(color: roseColor, width: 1.0)),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            contentPadding: const EdgeInsets.only(
                top: 12, bottom: 12, left: 8.0, right: 8.0),
            isDense: true,
            errorStyle: const TextStyle(
              color: darkredColor,
              fontSize: 12.0,
              fontWeight: fontMedium,
              letterSpacing: 1.2,
            ),
          ),
          controller: _phoneController,
          validator: (value) => phNoValidator(value!),
        ),
      ),
    );

    return number;
    /* return CustomTextFormFieldWidget(
      margin: const EdgeInsets.only(left: 25, top: 20, right: 25),
      hintText: phoneText,
      onFieldTap: () {},
      obscureText: false,
      textInputType: TextInputType.phone,
      actionKeyboard: TextInputAction.done,
      controller: _phoneController,
      focusNode: _phoneFocus,
      onSubmitField: () {},
      filledColor: whiteColor,
      isFilled: true,
      prefixIcon: const Padding(
        padding: EdgeInsets.only(left: 15, top: 15),
        child: Text("+1"),
      ),
      validator: (value) => phNoValidator(value),
      textStyle: textBoxTextStyle,
      enabled: false,
    );*/

    /* return Padding(
      padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
      child: IntlPhoneField(
        style: textBoxTextStyle,
        decoration: InputDecoration(
          hintText: 'Phone Number',
          fillColor: whiteColor,
          filled: true,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(color: mediumGreyColor, width: 1.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(color: mediumGreyColor, width: 1.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(color: roseColor, width: 1.0)),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
          ),
          contentPadding:
              const EdgeInsets.only(top: 12, bottom: 12, left: 8.0, right: 8.0),
          isDense: true,
          errorStyle: const TextStyle(
            color: darkredColor,
            fontSize: 12.0,
            fontWeight: fontMedium,
            letterSpacing: 1.2,
          ),
        ),
        controller: _phoneController,
        validator: (value) => phNoValidator(value.toString()),
        initialCountryCode: 'US',
        enabled: true,
        onChanged: (phone) {
          print(phone.completeNumber);
        },
      ),
    );*/
  }

  final _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();
  bool hidepassword = true;

  Widget _buildPassword() {
    return Stack(
      children: <Widget>[
        CustomTextFormFieldWidget(
          margin: const EdgeInsets.only(left: 25, top: 20, right: 25),
          hintText: passwordText,
          onFieldTap: () {},
          obscureText: hidepassword,
          textInputType: TextInputType.name,
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

  final _confirmpasswordController = TextEditingController();
  final _confirmpasswordFocus = FocusNode();
  bool hideconfirmpassword = true;

  Widget _confirmPassword() {
    return Stack(
      children: <Widget>[
        CustomTextFormFieldWidget(
          margin: const EdgeInsets.only(left: 25, top: 20, right: 25),
          hintText: confirmPasswordText,
          onFieldTap: () {},
          obscureText: hideconfirmpassword,
          textInputType: TextInputType.name,
          actionKeyboard: TextInputAction.done,
          controller: _confirmpasswordController,
          focusNode: _confirmpasswordFocus,
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
          validator: (value) =>
              confirmPasswordValidator(value, _passwordController.text),
          textStyle: textBoxTextStyle,
          enabled: false,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            padding: const EdgeInsets.only(right: 35, top: 33),
            onPressed: () => showHideforconfirm(),
            icon: Icon(
              hideconfirmpassword ? Icons.visibility_off : Icons.visibility,
              color: greyColor,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  showHideforconfirm() {
    setState(() {
      hideconfirmpassword = !hideconfirmpassword;
    });
  }

  Widget _checkbox() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Theme(
          data: ThemeData(
            unselectedWidgetColor: Colors.white, // Your color
          ),
          child: Checkbox(
            checkColor: Colors.white,
            activeColor: blueZodiacColor,
            value: valuefirst,
            onChanged: (bool? value) {
              setState(() {
                valuefirst = value ?? false;
              });
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 4),
          child: RichText(
            text: TextSpan(
                text: agreeText,
                style: darkgreyStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: agreeTermsText,
                    style: darkgreyUnderLineStyle,
                  ),
                ]),
          ),
        ),
      ]),
    );
  }

  Widget registerBtn() {
    return Center(
      child: CustomBtn(
        primaryColor: roseColor,
        surfaceColor: roseColor,
        buttonTestStyle: btntextTextStyle,
        buttonName: registerText,
        buttonMargin: const EdgeInsets.only(top: 10),
        buttonPadding: EdgeInsets.zero,
        buttonHeight: 50,
        buttonWidth: 170,
        buttonCornerRadius: 0,
        buttonBorderColor: roseColor,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            FocusScope.of(context).requestFocus(FocusNode());
            RegisterRequest register = RegisterRequest(
                email: _emailController.text,
                number: _phoneController.text,
                firstName: _firstnameController.text,
                role: "consumer",
                password: _confirmpasswordController.text);

            if (valuefirst) {
              _userBlocs.add(
                RegisterClickEvent(registerdetails: register),
              );
            } else {
              CustomAlertDialog.customAlert(
                  "CheckBox", "Please Agree terms and service");
            }
          }
        },
        textScaleFactor: 1.0,
      ),
    );
  }
}
