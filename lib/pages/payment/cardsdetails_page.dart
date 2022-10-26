import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/main.dart';
import 'package:shokuni_customer/models/response/cardsdetails_response.dart';
import 'package:shokuni_customer/pages/pages.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

class CardsDetailsPage extends StatefulWidget {
  static const String routeName = '/cardDetails';
  const CardsDetailsPage({Key? key}) : super(key: key);

  @override
  _CardsDetailsPageState createState() => _CardsDetailsPageState();
}

class _CardsDetailsPageState extends State<CardsDetailsPage> {
  final UserBloc userBlocs = UserBloc();

  List<CardDetails> cards = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocaldata();
  }

  void getlocaldata() async {
    userBlocs.add(const CardDetailsClickEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: addbtn(),
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                navigatorKey.currentState!.pop();
              },
            ),
            title: Text(
              cardDetailText.toUpperCase(),
              strutStyle: const StrutStyle(
                height: 6,
              ),
              style: textwithletterspacemediumStyle,
            ),
            backgroundColor: blueZodiacColor,
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          bloc: userBlocs,
          builder: (context, state) {
            if (state is CardsDetailsLoaded) {
              cards.clear();
              cards.addAll(state.details.data!);
            }
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
        cardsDetails(),
      ],
    );
  }

  Widget cardsDetails() {
    return cards.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 7,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 10),
                  title: Text(
                    cards[index].name.toString(),
                    style: blueBtnTextStyle,
                  ),
                  subtitle: Text(
                    cards[index].cardNumber.toString(),
                    style: regularRoseTextStyle,
                  ),
                  leading: Image.asset("assets/images/payment.png"),
                  trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_outlined),
                      color: Colors.black26,
                      iconSize: 20,
                      onPressed: () {
                        navigatorKey.currentState!.pushNamed(CardPage.routeName,
                            arguments: ArgumentsCards(details: cards[index]));
                      }),
                ),
              );
            },
          )
        : Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Text(
              "No Card found",
              textAlign: TextAlign.center,
              style: rosesemimediumtextStyle,
            ),
          );
  }

  Widget addbtn() {
    return FloatingActionButton(
      onPressed: () {
        navigatorKey.currentState!
            .pushNamed(PaymentPage.routeName)
            .then((value) => getlocaldata());
      },
      child: const Icon(
        Icons.add,
        size: 30,
      ),
      elevation: 5,
      backgroundColor: roseColor,
      splashColor: riverBedBlueColor,
    );
  }
}
