import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/models/model.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

class ProfileDetails extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final TextEditingController _firstnameController = TextEditingController();
  final _firstnameFocus = FocusNode();
  final TextEditingController _lastnameController = TextEditingController();
  final _lastnameFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final _phoneFocus = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final _emailFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool editoption = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customerBlocdetail.add(const GetUserClickEvent());
  }

  String? access_token;
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
      bottomNavigationBar: editoption ? editBtn() : buttons(),
      body: BlocBuilder<CustomerBloc, CustomerState>(
        bloc: customerBlocdetail,
        builder: (context, state) {
          if (state is CustomerdetailLoaded) {
            _firstnameController.text = state.userdetail.firstName.toString();
            _lastnameController.text = state.userdetail.lastName.toString();
            _phoneController.text = state.userdetail.number.toString();
            _emailController.text = state.userdetail.email.toString();
          }
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
            txtName: firstNameText,
            margin: const EdgeInsets.only(left: 25, bottom: 5, top: 30),
            style: blueBtnTextStyle,
            align: TextAlign.start,
          ),
          _buildfirstname(),
          CustomText(
            txtName: lastNameText,
            margin: const EdgeInsets.only(left: 25, bottom: 5, top: 30),
            style: blueBtnTextStyle,
            align: TextAlign.start,
          ),
          _buildlastname(),
          CustomText(
            txtName: phoneText,
            margin: const EdgeInsets.only(left: 25, bottom: 5, top: 30),
            style: blueBtnTextStyle,
            align: TextAlign.start,
          ),
          _buildPhone(),
          CustomText(
            txtName: emailText,
            margin: const EdgeInsets.only(left: 25, bottom: 5, top: 30),
            style: blueBtnTextStyle,
            align: TextAlign.start,
          ),
          _buildEmail(),
        ],
      ),
    );
  }

  Widget editBtn() {
    return CustomBtn(
      primaryColor: roseColor,
      surfaceColor: roseColor,
      buttonTestStyle: titleWhiteTextStyle,
      buttonName: editText,
      buttonMargin: const EdgeInsets.all(25),
      buttonPadding: EdgeInsets.zero,
      buttonHeight: 50,
      buttonWidth: double.infinity,
      buttonCornerRadius: 0,
      buttonBorderColor: roseColor,
      onPressed: () {
        setState(() {
          editoption = false;
        });
      },
      textScaleFactor: 1.0,
    );
  }

  Widget _buildfirstname() {
    return CustomTextFormFieldWidget(
      margin: const EdgeInsets.only(left: 25, right: 25),
      hintText: firstNameText,
      onFieldTap: () {},
      obscureText: false,
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.done,
      controller: _firstnameController,
      focusNode: _firstnameFocus,
      onSubmitField: () {},
      filledColor: whiteColor,
      isFilled: true,
      prefixIcon: const Icon(
        Icons.person_rounded,
      ),
      validator: (value) => commonValidator(value, enterNameText),
      textStyle: textBoxTextStyle,
      enabled: editoption,
    );
  }

  Widget _buildlastname() {
    return CustomTextFormFieldWidget(
      margin: const EdgeInsets.only(left: 25, right: 25),
      hintText: lastNameText,
      onFieldTap: () {},
      obscureText: false,
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.done,
      controller: _lastnameController,
      focusNode: _lastnameFocus,
      onSubmitField: () {},
      filledColor: whiteColor,
      isFilled: true,
      prefixIcon: const Icon(
        Icons.person_rounded,
      ),
      validator: (value) => commonValidator(value, enterNameText),
      textStyle: textBoxTextStyle,
      enabled: editoption,
    );
  }

  Widget _buildPhone() {
    return CustomTextFormFieldWidget(
      margin: const EdgeInsets.only(left: 25, right: 25),
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
      prefixIcon: const Icon(
        Icons.phone,
      ),
      validator: (value) => phNoValidator(value),
      textStyle: textBoxTextStyle,
      enabled: editoption,
    );
  }

  Widget _buildEmail() {
    return CustomTextFormFieldWidget(
      margin: const EdgeInsets.only(left: 25, right: 25),
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
      prefixIcon: const Icon(
        Icons.email,
      ),
      validator: (value) => validateEmailField(value),
      textStyle: textBoxTextStyle,
      enabled: true,
    );
  }

  Widget buttons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: updateInBtn()),
        Expanded(child: cancelBtn()),
      ],
    );
  }

  Widget updateInBtn() {
    return CustomBtn(
      primaryColor: roseColor,
      surfaceColor: roseColor,
      buttonTestStyle: whiteBtnTextStyle,
      buttonName: updatesText,
      buttonMargin:
          const EdgeInsets.only(top: 40, right: 10, left: 30, bottom: 40),
      buttonPadding: EdgeInsets.zero,
      buttonHeight: 50,
      buttonWidth: double.infinity,
      buttonCornerRadius: 0,
      buttonBorderColor: roseColor,
      onPressed: () async {
        UpdateUserRequest userUpdate = UpdateUserRequest(
            number: _phoneController.text,
            lastName: _lastnameController.text,
            firstName: _firstnameController.text,
            email: _emailController.text);
        customerBlocdetail
            .add(UpdateUserClickEvent(userUpdateDetails: userUpdate));
        setState(() {
          editoption = true;
        });
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
        setState(() {
          editoption = true;
        });
      },
      textScaleFactor: 1.0,
    );
  }
}
