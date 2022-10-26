import '../../main.dart';
import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/cache/local_storage.dart';
import 'package:shokuni_customer/models/model.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

class BarberDetailsPage extends StatefulWidget {
  static const String routeName = '/barberDetails';
  const BarberDetailsPage({Key? key}) : super(key: key);

  @override
  _BarberDetailsPageState createState() => _BarberDetailsPageState();
}

class Arguments {
  final Open? data;
  final List<Promotionss>? promotiondetails;

  Arguments({this.data, this.promotiondetails});
}

class _BarberDetailsPageState extends State<BarberDetailsPage> {
  bool selected = false;
  late Arguments args;
  final _comment = TextEditingController();
  final CustomerBloc customerBlocs = CustomerBloc();

  double? totalamount = 0;
  double cutamount = 0;
  double cutextrasamount = 0;

  String? id;
  String? accessToken;
  String? username;
  String? barberId;
  AlreadyInQueueResponse? queueData;

  @override
  void initState() {
    // TODO: implement initState
    getLocalData();

    super.initState();
  }

  double updateTotalAmount() {
    totalamount = 0;
    cutamount = 0;
    cutextrasamount = 0;
    if (args.data != null) {
      for (var items in args.data!.cutType!) {
        if (items.isSelect == true) {
          cutamount = double.parse(items.amount!);
        }
      }

      for (var items in args.data!.cutExtras!) {
        if (items.isSelect == true) {
          cutextrasamount = cutextrasamount + double.parse(items.amount!);
        }
      }
      totalamount = cutamount + cutextrasamount;
    }
    return totalamount!;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    args = ModalRoute.of(context)!.settings.arguments as Arguments;
  }

  void getLocalData() async {
    accessToken = await LocalStorageService.getToken();
    id = await LocalStorageService.getId();
    username = await LocalStorageService.getName();
    customerBlocs.add(const AlreadyinQueueClickEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigatorKey.currentState!.pop();
        return true;
      },
      child: BlocBuilder<CustomerBloc, CustomerState>(
        bloc: customerBlocs,
        builder: (context, state) {
          if (state is CustomeralreadyLoaded) {
            queueData = state.queueDetails;
          }

          return Scaffold(
            bottomNavigationBar: showButtons(),
            backgroundColor: lightGreyColor,
            body: LoadingIndicator(
              isLoading: state is CustomerLoading ? true : false,
              widget: body(),
            ),
          );
        },
      ),
    );
  }

  Widget showButtons() {
    if (queueData != null && queueData!.data != null) {
      if (queueData!.data!.saloonId.toString() == args.data!.id.toString() &&
          queueData!.data!.state == "waiting") {
        return cancelqueuebtn();
      } else if (queueData!.data!.saloonId.toString() !=
          args.data!.id.toString()) {
        if (queueData!.message == "You are already in queue.") {
          return emptyWidget();
        }
        if (queueData!.data!.state == "attending") {
          return emptyWidget();
        } else {
          return joinqueuebtn();
        }
      } else {
        return emptyWidget();
      }
    } else {
      return joinqueuebtn();
    }
  }

  Widget emptyWidget() {
    return const SizedBox();
  }

  Widget body() {
    return ListView(children: [
      headline(),
      secondline(),
    ]);
  }

  Widget joinqueuebtn() {
    return CustomBtn(
      onPressed: () {
        List<String> cuttype = [];
        List<int> cutextras = [];
        if (selected) {
          for (var items in args.data!.cutType!) {
            if (items.isSelect == true) {
              cuttype.add(items.id.toString());
            }
          }
          for (var items in args.data!.cutExtras!) {
            if (items.isSelect == true) {
              cutextras.add(items.id!);
            }
          }
          JoinQueueRequest joinqueueDetails = JoinQueueRequest(
              shopId: args.data!.id.toString(),
              cutType: cuttype.join(","),
              cutExtras: cutextras,
              customerName: username,
              details: _comment.text,
              customerId: id.toString());

          customerBlocs
              .add(JoinQueueClickEvent(joinQueueDetails: joinqueueDetails));
        } else {
          CustomAlertDialog.customAlert(
              "Ensure Selection", "Please Select the Style");
        }
      },
      buttonCornerRadius: 0,
      buttonBorderColor: blueZodiacColor,
      textScaleFactor: 1,
      buttonHeight: 50,
      buttonMargin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      buttonName: joinQueueText.toUpperCase(),
      surfaceColor: blueZodiacColor,
      primaryColor: blueZodiacColor,
      buttonPadding: const EdgeInsets.all(0),
      buttonTestStyle: whiteBtnlightTextStyle,
      buttonWidth: double.infinity,
    );
  }

  Widget cancelqueuebtn() {
    return CustomBtn(
      onPressed: () {
        cancelQueueAlertDialog();
      },
      buttonCornerRadius: 0,
      buttonBorderColor: roseColor,
      textScaleFactor: 1,
      buttonHeight: 50,
      buttonMargin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      buttonName: cancelQueueText.toUpperCase(),
      surfaceColor: roseColor,
      primaryColor: roseColor,
      buttonPadding: const EdgeInsets.all(0),
      buttonTestStyle: whiteBtnlightTextStyle,
      buttonWidth: double.infinity,
    );
  }

  Widget headline() {
    return Stack(children: <Widget>[
      Image.network(
        args.data!.headerImage!,
        fit: BoxFit.fill,
        height: 225,
        width: double.infinity,
      ),
      IconButton(
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
          icon: const Icon(Icons.clear, color: whiteColor)),
      const SizedBox(
        height: 90,
      ),
      Center(
        child: //profileInQueue(),
            profileImage(),
      ),
      const Padding(
        padding: EdgeInsets.only(top: 290, left: 180),
        child: ImageIcon(AssetImage("assets/images/clock.png"), size: 14),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 290, left: 200),
        child: RichText(
          text: TextSpan(
            text: args.data!.waitTime.toString(),
            style: lightTextStyle,
            children: <TextSpan>[
              TextSpan(
                text: 'min',
                style: blueSubScriptTextStyle,
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(
          top: 320,
        ),
        height: 320,
        width: double.infinity,
        color: whiteColor,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              " " + promotionText,
              style: textwithletterspaceStyle,
            ),
          ),
          Flexible(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: args.promotiondetails!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 275,
                    child: Card(
                      margin:
                          const EdgeInsets.only(left: 12, top: 12, bottom: 5),
                      elevation: 8,
                      shadowColor: whiteColor,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              args.promotiondetails![index].image!,
                              height: 180,
                              width: 400,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: Text(
                                args.promotiondetails![index].title.toString(),
                                style: textTitlesemiStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 15, right: 10),
                              child: Text(
                                args.promotiondetails![index].content
                                    .toString(),
                                style: textContentsemiStyle,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.zero,
                              child: SizedBox(
                                height: 30,
                                child: TextButton(
                                  child: Text(
                                    moreText,
                                    style: textbtnsemiStyle,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ]),
                    ),
                  );
                }),
          ),
        ]),
      ),
    ]);
  }

  Widget secondline() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(
          color: whiteColor,
          border: Border(top: BorderSide(width: 1, color: greyColor))),
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: ImageIcon(
                AssetImage("assets/images/location.png"),
                size: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              args.data!.address!,
              style: textsemiStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              args.data!.distance.toString(),
              style: textsemiStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              directionText,
              style: textsemiStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              args.data!.contactNumber!,
              style: textsemiBoldStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 4,
              thickness: 1.5,
            ),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  standardText,
                  style: textmediumBoldStyle,
                ),
                leading: const Padding(
                  padding: EdgeInsets.all(10),
                  child: ImageIcon(
                    AssetImage("assets/images/haircut.png"),
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 230, top: 10),
                    child: Text(
                      styleText,
                      style: textmediumsemiStyle,
                    ),
                  ),
                  showCutDetailsWidget(),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                    ),
                    child: Divider(
                      color: greyColor,
                      height: 40,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 210),
                    child: Text(
                      extraText,
                      style: textmediumsemiStyle,
                    ),
                  ),
                  showCutExtraDetailsWidget(),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 4,
              thickness: 1.5,
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.all(10),
                child: ImageIcon(
                  AssetImage("assets/images/comment.png"),
                ),
              ),
              title: Text(
                comment1Text,
                style: textmediumBoldStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                controller: _comment,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: comment2Text,
                  hintStyle: textmediumBoldsizeStyle,
                ),
              ),
            ),
            const Divider(
              height: 8,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: RichText(
                text: TextSpan(
                  text: "total: ",
                  style: textsemicolorStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: args.data != null
                          ? '€ ${updateTotalAmount()}'
                          : '€ 0',
                      style: textsemiboldrStyle,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget profileImage() {
    return Container(
      margin: const EdgeInsets.only(top: 180),
      width: 200,
      height: 100,
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            Image.network(
              args.data!.saloonLogo!,
              height: 70,
              width: 70,
            ),
            Text(
              args.data!.name!,
              style: textwithletterspacesemiStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget profileInQueue() {
    return Container(
      margin: const EdgeInsets.only(top: 170),
      width: 200,
      height: 100,
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            Text(
              youAreText.toUpperCase(),
              style: greytextmediumStyle,
            ),
            Text(
              "QUEUE POSITION \u{207f}\u{1d48} ",
              style: greytextboldStyle,
            ),
            Text(
              inQueueText.toUpperCase(),
              style: greytextmediumStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget showCutDetailsWidget() {
    List<Widget> colList = <Widget>[];
    if (args.data != null) {
      if (args.data!.cutType!.isNotEmpty) {
        for (int i = 0; i < args.data!.cutType!.length; i++) {
          colList.add(customCutTypeCheckBoxWidget(args.data!.cutType![i], i));
        }
      }
      return Column(
        children: colList,
      );
    } else {
      return const SizedBox();
    }
  }

  Widget customCutTypeCheckBoxWidget(CutType cutType, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: CheckboxListTile(
        value: cutType.isSelect,
        onChanged: (value) {
          for (int i = 0; i < args.data!.cutType!.length; i++) {
            if (args.data!.cutType![i].id.toString() == cutType.id.toString()) {
              setState(() {
                cutType.isSelect = true;
                args.data!.cutType![i].isSelect = true;
                selected = cutType.isSelect!;
              });
            } else {
              setState(() {
                //cutType.isSelected = false;
                args.data!.cutType![i].isSelect = false;
              });
            }
          }
        },
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        checkColor: whiteColor,
        dense: true,
        tristate: false,
        activeColor: roseColor,
        title: Text(
          cutType.name.toString(),
          style: bluetextsemiStyle,
        ),
        secondary: Text(
          cutType.amount.toString(),
          style: bluetextsemiStyle,
        ),
      ),
    );
  }

  Widget showCutExtraDetailsWidget() {
    List<Widget> colList = <Widget>[];
    if (args.data != null) {
      if (args.data!.cutExtras!.isNotEmpty) {
        for (int i = 0; i < args.data!.cutExtras!.length; i++) {
          colList
              .add(customCutExtraCheckBoxWidget(args.data!.cutExtras![i], i));
        }
      }
      return Column(
        children: colList,
      );
    } else {
      return const SizedBox();
    }
  }

  Widget customCutExtraCheckBoxWidget(CutExtras cutExtra, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: CheckboxListTile(
        value: cutExtra.isSelect,
        onChanged: (value) {
          setState(() => cutExtra.isSelect = value);

          args.data!.cutExtras![index].isSelect = value;
        },
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        checkColor: whiteColor,
        dense: true,
        tristate: false,
        activeColor: roseColor,
        title: Text(
          cutExtra.name.toString(),
          style: bluetextsemiStyle,
        ),
        secondary: Text(
          cutExtra.amount.toString(),
          style: bluetextsemiStyle,
        ),
      ),
    );
  }

  cancelQueueAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return cancelQueueDialog();
        });
  }

  Widget cancelQueueDialog() {
    return Dialog(
        backgroundColor: transparentColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0),
          ),
        ),
        child: SizedBox(
          height: 375,
          child: Stack(children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: blueZodiacColor, width: 2),
              ),
              height: 250,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 70),
                    child: Text(
                      confirmCancelText,
                      style: bluetextBoldStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        confirmCancelContentText,
                        style: bluetextSemiStyle,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      confirmCancelContent1Text,
                      style: bluetextSemiStyle,
                    ),
                  ),
                  Center(
                    child: Text(
                      confirmCancelContent2Text,
                      style: bluetextSemiStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      controller: _comment,
                      decoration: InputDecoration(
                        hintText: commentText,
                        hintStyle: greytextmediumStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 130, top: 10),
              child: CircleAvatar(
                radius: 27,
                backgroundColor: blueZodiacColor,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: whiteColor,
                  child: Icon(
                    Icons.clear,
                    size: 40,
                    color: blueZodiacColor,
                  ),
                ),
              ),
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 260),
                child: SizedBox(
                  height: 40,
                  child: CustomBtn(
                    primaryColor: blueZodiacColor,
                    surfaceColor: blueZodiacColor,
                    buttonTestStyle: whiteBtnTextStyle,
                    buttonName: confirmText.toUpperCase(),
                    buttonMargin: const EdgeInsets.only(),
                    buttonPadding: EdgeInsets.zero,
                    buttonHeight: 0,
                    buttonWidth: 120,
                    buttonCornerRadius: 0,
                    buttonBorderColor: roseColor,
                    onPressed: () {
                      {
                        LeaveQueueRequest leaveQueue = LeaveQueueRequest(
                            comment: _comment.text,
                            queueId: queueData!.data!.id.toString());

                        customerBlocs
                            .add(LeaveQueueClickEvent(leaveQueue: leaveQueue));

                        navigatorKey.currentState!.pop();
                      }
                    },
                    textScaleFactor: 1.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 260),
                child: SizedBox(
                  height: 40,
                  child: CustomBtn(
                    primaryColor: blueZodiacColor,
                    surfaceColor: blueZodiacColor,
                    buttonTestStyle: whiteBtnTextStyle,
                    buttonName: cancelText.toUpperCase(),
                    buttonMargin: const EdgeInsets.only(),
                    buttonPadding: EdgeInsets.zero,
                    buttonHeight: 0,
                    buttonWidth: 120,
                    buttonCornerRadius: 0,
                    buttonBorderColor: roseColor,
                    onPressed: () {
                      {
                        navigatorKey.currentState!.pop();
                      }
                    },
                    textScaleFactor: 1.0,
                  ),
                ),
              ),
            ])
          ]),
        ));
  }
}
