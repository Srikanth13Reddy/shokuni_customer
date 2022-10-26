import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/main.dart';
import 'package:shokuni_customer/models/model.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

class ChangePasswordPage extends StatefulWidget {
  static const String routeName = '/changepassword';
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldpasswordController = TextEditingController();
  final _oldpasswordFocus = FocusNode();
  final TextEditingController _newpasswordController = TextEditingController();
  final _newpasswordFocus = FocusNode();
  bool hidepassword = true;
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final _confirmpasswordFocus = FocusNode();
  bool hideconfirmpassword = true;

  final _formKey = GlobalKey<FormState>();

  CustomerBloc customerBlocdetail = CustomerBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          shokuniText,
          style: GoogleFonts.workSans(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: blueZodiacColor,
      ),
      bottomNavigationBar: buttons(),
      body: BlocBuilder<CustomerBloc, CustomerState>(
        bloc: customerBlocdetail,
        builder: (context, state) {
          return LoadingIndicator(
            isLoading: state is CustomerLoading ? true : false,
            widget: body(),
          );
        },
      ),
    );
  }

  Widget body() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: [
          CustomText(
            txtName: oldpasswordText,
            margin: const EdgeInsets.only(left: 25, bottom: 5, top: 30),
            style: blueBtnTextStyle,
            align: TextAlign.start,
          ),
          _buildoldpassword(),
          CustomText(
            txtName: newpasswordText,
            margin: const EdgeInsets.only(left: 25, bottom: 5, top: 30),
            style: blueBtnTextStyle,
            align: TextAlign.start,
          ),
          _buildnewpassword(),
          CustomText(
            txtName: confirmpasswordText,
            margin: const EdgeInsets.only(left: 25, bottom: 5, top: 30),
            style: blueBtnTextStyle,
            align: TextAlign.start,
          ),
          _buildconfirmpassword(),
        ],
      ),
    );
  }

  Widget _buildoldpassword() {
    return CustomTextFormFieldWidget(
      margin: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 20,
      ),
      hintText: oldpasswordText,
      onFieldTap: () {},
      obscureText: false,
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.done,
      controller: _oldpasswordController,
      focusNode: _oldpasswordFocus,
      onSubmitField: () {},
      filledColor: whiteColor,
      isFilled: true,
      prefixIcon: const Icon(
        Icons.password_sharp,
      ),
      validator: (value) => commonValidator(value, enterOldPasswordText),
      textStyle: textBoxTextStyle,
      enabled: false,
    );
  }

  Widget _buildnewpassword() {
    return Stack(
      children: <Widget>[
        CustomTextFormFieldWidget(
          margin: const EdgeInsets.only(left: 25, top: 20, right: 25),
          hintText: newpasswordText,
          onFieldTap: () {},
          obscureText: hidepassword,
          textInputType: TextInputType.name,
          actionKeyboard: TextInputAction.done,
          controller: _newpasswordController,
          focusNode: _newpasswordFocus,
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

  Widget _buildconfirmpassword() {
    return Stack(
      children: <Widget>[
        CustomTextFormFieldWidget(
          margin: const EdgeInsets.only(left: 25, top: 20, right: 25),
          hintText: confirmpasswordText,
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
              confirmPasswordValidator(value, _newpasswordController.text),
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

  Widget buttons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: saveInBtn()),
        Expanded(child: cancelBtn()),
      ],
    );
  }

  Widget saveInBtn() {
    return CustomBtn(
      primaryColor: roseColor,
      surfaceColor: roseColor,
      buttonTestStyle: whiteBtnTextStyle,
      buttonName: saveText,
      buttonMargin:
          const EdgeInsets.only(top: 40, right: 10, left: 30, bottom: 40),
      buttonPadding: EdgeInsets.zero,
      buttonHeight: 50,
      buttonWidth: double.infinity,
      buttonCornerRadius: 0,
      buttonBorderColor: roseColor,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          FocusScope.of(context).requestFocus(FocusNode());
          ChangePasswordRequest password = ChangePasswordRequest(
            oldPassword: _oldpasswordController.text,
            newPassword: _newpasswordController.text,
            confirmPassword: _confirmpasswordController.text,
          );
          customerBlocdetail.add(ChangePasswordClickEvent(
            changepassword: password,
          ));
        }
      },
      textScaleFactor: 1.0,
    );
  }

  Widget cancelBtn() {
    return CustomBtn(
      primaryColor: roseColor,
      surfaceColor: roseColor,
      buttonTestStyle: whiteBtnTextStyle,
      buttonName: cancelText,
      buttonMargin:
          const EdgeInsets.only(top: 40, right: 30, left: 10, bottom: 40),
      buttonPadding: EdgeInsets.zero,
      buttonHeight: 50,
      buttonWidth: double.infinity,
      buttonCornerRadius: 0,
      buttonBorderColor: roseColor,
      onPressed: () {
        navigatorKey.currentState!.pop();
      },
      textScaleFactor: 1.0,
    );
  }
}
