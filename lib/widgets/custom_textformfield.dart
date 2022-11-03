import 'package:masked_text/masked_text.dart';
import 'package:shokuni_customer/styles/styles.dart';

/// *  textInputType - The type of information for which to optimize the text input control.
/// *  hintText - Text that suggests what sort of input the field accepts.
/// *  prefixIcon - Pass Icon if required
/// *  defaultText - If there is predefined value is there for a text field
/// *  focusNode - Currently focus node
/// *  obscureText - Is Password field?
/// *  controller - Text controller
/// *  functionValidate - Validation function(currently I have used to check empty field)
/// *  parametersValidate - Value to validate
/// *  actionKeyboard - Keyboard action eg. next, done, search, etc
/// *  onSubmitField - Done click action
/// *  onFieldTap - On focus on TextField
class CustomTextFormFieldWidget extends StatefulWidget {
  final EdgeInsets margin;
  final TextInputType textInputType;
  final String hintText;
  final Widget? prefixIcon;
  final String? defaultText;
  final FocusNode focusNode;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputAction actionKeyboard;
  final Function onSubmitField;
  final Function onFieldTap;
  final bool isFilled;
  final Color? filledColor;
  final String? Function(String) validator;
  final TextStyle textStyle;
  final bool enabled;
  final double radius;
  final String? mask;

  const CustomTextFormFieldWidget({
    Key? key,
    required this.margin,
    required this.hintText,
    required this.focusNode,
    required this.textInputType,
     this.mask,
    this.defaultText,
    this.obscureText = false,
    required this.controller,
    this.actionKeyboard = TextInputAction.next,
    required this.onSubmitField,
    required this.onFieldTap,
    this.prefixIcon,
    required this.filledColor,
    required this.isFilled,
    required this.validator,
    required this.textStyle,
    required this.enabled,
    this.radius = 0,
  }) : super(key: key);

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: blueZodiacColor,
        ),
        child: widget.mask==null||widget.mask!.isEmpty?TextFormField(
          //mask: widget.mask,
          cursorColor: blueZodiacColor,
          obscureText: widget.obscureText,
          keyboardType: widget.textInputType,
          textInputAction: widget.actionKeyboard,
          textCapitalization: TextCapitalization.sentences,
          focusNode: widget.focusNode,
          style: widget.textStyle,
          readOnly: widget.enabled,
          initialValue: widget.defaultText,
          decoration: InputDecoration(
            fillColor: widget.filledColor,
            filled: widget.isFilled,
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide:
                    const BorderSide(color: mediumGreyColor, width: 1.0)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide:
                    const BorderSide(color: mediumGreyColor, width: 1.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: const BorderSide(color: roseColor, width: 1.0)),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            contentPadding: EdgeInsets.only(
                top: 12, bottom: bottomPaddingToError, left: 8.0, right: 8.0),
            isDense: true,
            errorStyle: const TextStyle(
              color: darkredColor,
              fontSize: 12.0,
              fontWeight: fontMedium,
              letterSpacing: 1.2,
            ),
          ),
          controller: widget.controller,
          validator: (value) => widget.validator(value!),
          onFieldSubmitted: (value) {
            widget.onSubmitField();
          },
          onTap: () {
            widget.onFieldTap();
          },
        ):MaskedTextField(
          mask: widget.mask,
          cursorColor: blueZodiacColor,
          obscureText: widget.obscureText,
          keyboardType: widget.textInputType,
          textInputAction: widget.actionKeyboard,
          textCapitalization: TextCapitalization.sentences,
          focusNode: widget.focusNode,
          style: widget.textStyle,
          readOnly: widget.enabled,
          initialValue: widget.defaultText,
          decoration: InputDecoration(
            fillColor: widget.filledColor,
            filled: widget.isFilled,
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide:
                const BorderSide(color: mediumGreyColor, width: 1.0)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide:
                const BorderSide(color: mediumGreyColor, width: 1.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: const BorderSide(color: roseColor, width: 1.0)),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            contentPadding: EdgeInsets.only(
                top: 12, bottom: bottomPaddingToError, left: 8.0, right: 8.0),
            isDense: true,
            errorStyle: const TextStyle(
              color: darkredColor,
              fontSize: 12.0,
              fontWeight: fontMedium,
              letterSpacing: 1.2,
            ),
          ),
          controller: widget.controller,
          validator: (value) => widget.validator(value!),
          onFieldSubmitted: (value) {
            widget.onSubmitField();
          },
          onTap: () {
            widget.onFieldTap();
          },
        ),
      ),
    );
  }
}

String? commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  if (required != null) {
    return required;
  }
  return null;
}

String? requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

void changeFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
