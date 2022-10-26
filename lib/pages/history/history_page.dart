import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/cache/local_storage.dart';
import 'package:shokuni_customer/models/model.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

import '../../main.dart';

class HistoryPage extends StatefulWidget {
  static const String routeName = '/history';
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final CustomerBloc customerBloch = CustomerBloc();
  @override
  void initState() {
    // TODO: implement initState
    getlocaldata();
    super.initState();
  }

  String? accessToken;
  List<Data?> history = [];

  void getlocaldata() async {
    accessToken = await LocalStorageService.getToken();
    customerBloch.add(const HistoryClickEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              historyText.toUpperCase(),
              strutStyle: const StrutStyle(
                height: 6,
              ),
              style: textwithletterspacemediumStyle,
            ),
            backgroundColor: blueZodiacColor,
          ),
        ),
        body: BlocBuilder<CustomerBloc, CustomerState>(
          bloc: customerBloch,
          builder: (context, state) {
            if (state is CustomerHistoryLoaded) {
              history.addAll(state.historydetail.data!);
            }
            return LoadingIndicator(
              isLoading: state is CustomerLoading ? true : false,
              widget: body(),
            );
          },
        ),
      ),
    );
  }

  Widget body() {
    return ListView(children: [
      historypage(),
    ]);
  }

  Widget historypage() {
    return history.isNotEmpty
        ? ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: history.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: frostColor, width: 1.5),
                ),
                child: Card(
                  elevation: 6,
                  margin: const EdgeInsets.all(0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(history[index]!.headerImage!),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            // height: 300,
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 100,
                              ),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.black26,
                                      spreadRadius: 5)
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 47,
                                backgroundColor: whiteColor,
                                child: Image.network(
                                  history[index]!.saloonLogo!,
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                              title: Text(
                                history[index]!.customerName!,
                                style: bluetextboldStyle,
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                history[index]!.date!,
                                style: rosesemimediumtextStyle,
                                textAlign: TextAlign.center,
                              )),
                          const Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: Divider(
                              thickness: 1.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 30, top: 10),
                            child: Text(
                              customerInvoiceText,
                              style: mediumBlueTextStyle,
                            ),
                          ),
                          Column(
                            children: customerinvoivelist(
                                history[index]!.customerServices!),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: Divider(
                              thickness: 1.5,
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 30,
                                    bottom: 20,
                                    top: 10,
                                  ),
                                  child: Text(
                                    "total: \u{20B9}" +
                                        history[index]!
                                            .transaction!
                                            .totalAmount!
                                            .toString(),
                                    style: normalsemitextStyle,
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })
        : nodatafound();
  }

  List<Widget> customerinvoivelist(List<CustomerServices> historyData) {
    List<Widget> customerinvoice = [];
    if (historyData.isNotEmpty) {
      for (int i = 0; i < historyData.length; i++) {
        customerinvoice.add(Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    historyData[i].name!,
                    style: normaltext1Style,
                  ),
                  Text(
                    historyData[i].amount!,
                    style: normaltext1Style,
                  ),
                ]),
          ),
        ]));
      }
      return customerinvoice;
    } else {
      return customerinvoice;
    }
  }

  Widget nodatafound() {
    return Container(
      margin: const EdgeInsets.only(top: 200),
      child: Column(
        children: [
          Image.asset(
            'assets/images/barber-wheel.png',
            height: 70,
          ),
          Text(nothingText,
              style: greytextnormalcolorStyle, overflow: TextOverflow.ellipsis),
          const SizedBox(
            height: 10,
          ),
          Text(
            nothing1Text,
            style: greynormaltextStyle,
          ),
          Text(
            nothing2Text,
            style: greynormaltextStyle,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 40,
            child: CustomBtn(
              primaryColor: lightblueColor,
              surfaceColor: lightblueColor,
              buttonTestStyle: whiteBtnTextStyle,
              buttonName: browseBarberText.toUpperCase(),
              buttonMargin: const EdgeInsets.only(),
              buttonPadding: EdgeInsets.zero,
              buttonHeight: 50,
              buttonWidth: 200,
              buttonCornerRadius: 0,
              buttonBorderColor: roseColor,
              onPressed: () {
                {}
              },
              textScaleFactor: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
