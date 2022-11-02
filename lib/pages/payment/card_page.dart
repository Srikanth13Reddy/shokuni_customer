import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/models/response/cardsdetails_response.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';
import 'package:masked_text/masked_text.dart';

class CardPage extends StatefulWidget {
  static const String routeName = '/card';
  const CardPage({Key? key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class ArgumentsCards {
  final CardDetails? details;

  ArgumentsCards({this.details});
}

class _CardPageState extends State<CardPage> {
  final UserBloc userBlocs = UserBloc();
  late ArgumentsCards args;
  bool isChecked = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    try {
      args = ModalRoute.of(context)!.settings.arguments as ArgumentsCards;
    } catch (e) {
      print('Card Page $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGreyColor,
        appBar: CustomAppBar(
          title: card1Text.toUpperCase(),
          height: 240,
          assetIcon: 'assets/images/payment.png',
          iconsize: 50,
          bordercolor: blueZodiacColor,
        ),
        body: BlocBuilder<UserBloc, UserState>(
          bloc: userBlocs,
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
    return ListView(
      children: [
        carddetails(),
      ],
    );
  }

  Widget carddetails() {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25),
          child: ListTile(
            title: Text(
              cardDetailText,
              style: bluetextBoldStyle,
            ),
          ),
        ),
        const Divider(
          height: 3,
          thickness: 1.5,
        ),
        Container(
          color: whiteColor,
          child: ListTile(
            dense: true,
            title: Text(
              cardNameText,
              style: lightTextStyle,
            ),
            subtitle: Text(
              args.details!.name!,
              style: darkTextStyle,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1.5,
        ),
        Container(
          color: whiteColor,
          child: ListTile(
            dense: true,
            title: Text(
              cardText,
              style: lightTextStyle,
            ),
            subtitle: Text(
              args.details!.cardNumber!,
              style: darkTextStyle,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1.5,
        ),
        Container(
          color: whiteColor,
          child: ListTile(
            dense: true,
            title: Text(
              cscText,
              style: lightTextStyle,
            ),
            subtitle: Text(
              args.details!.cardCvv!,
              style: darkTextStyle,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1.5,
        ),
        Container(
            color: whiteColor,
            child: ListTile(
              dense: true,
              title: Text(
                expiryText,
                style: lightTextStyle,
              ),
              subtitle: Text(
                args.details!.expiry!,
                style: darkTextStyle,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            )),
        const Divider(
          height: 1,
          thickness: 1.5,
        ),
        _verify(),
      ],
    );
  }

  Widget _verify() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Checkbox(
              value: isChecked,
              onChanged: (bool? yes) {
                setState(() {
                  isChecked = yes!;
                });
              }),
          Container(
            margin: const EdgeInsets.only(left: 4),
            child: Text(
              "Card Changes Accepted",
              style: lightgreymediumStyle,
            ),
          ),
        ],
      ),
    );
  }
}
