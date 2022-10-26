import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/cache/local_storage.dart';
import 'package:shokuni_customer/main.dart';
import 'package:shokuni_customer/models/model.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

class NotificationPage extends StatefulWidget {
  static const String routeName = '/notification';
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

final CustomerBloc customerBlocs = CustomerBloc();

class _NotificationPageState extends State<NotificationPage> {
  List<Notifications> notify = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: CustomAppBar(
        title: notificationText.toUpperCase(),
        height: 220,
        assetIcon: 'assets/images/payment.png',
        iconsize: 50,
        bordercolor: blueZodiacColor,
      ),
      body: BlocBuilder<CustomerBloc, CustomerState>(
        bloc: customerBlocs,
        builder: (context, state) {
          if (state is CustomerNotificationLoaded) {
            notify.clear();
            notify.addAll(state.notify.data!);
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
    return ListView(children: [
      const SizedBox(
        height: 30,
      ),
      header(),
    ]);
  }

  Widget header() {
    return notify.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: notify.length,
            itemBuilder: (context, index) {
              return NotificationDetail(
                notifyTitle: notify[index].title.toString(),
                notifyTime: notify[index].dateTime.toString(),
                notifyMsg: notify[index].message.toString(),
              );
            })
        : const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 200),
              child: Text('No Data Found'),
            ),
          );
  }
}

class NotificationDetail extends StatelessWidget {
  final String notifyTitle;
  final String notifyMsg;
  final String notifyTime;
  const NotificationDetail({
    Key? key,
    required this.notifyTitle,
    required this.notifyMsg,
    required this.notifyTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showNotifyAlertDialog(context),
      child: Container(
        decoration: const BoxDecoration(
          color: whiteColor,
          border: Border(
            top: BorderSide(
              color: Colors.black12,
              width: 1,
            ),
            bottom: BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
        ),
        padding:
            const EdgeInsets.only(left: 30, right: 20, top: 15, bottom: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  txtName: notifyTitle,
                  margin: EdgeInsets.zero,
                  style: mediumBlueTextStyle,
                  align: TextAlign.start,
                ),
                const SizedBox(
                  width: 15,
                ),
                CustomText(
                  txtName: notifyTime,
                  margin: EdgeInsets.zero,
                  style: bluesemitextStyle,
                  align: TextAlign.start,
                ),
              ],
            ),
            CustomText(
              txtName: notifyMsg,
              margin: const EdgeInsets.only(top: 8),
              style: bluesemitextStyle,
              align: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }

  showNotifyAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return NotifyDialog(
            titleText: notifyTitle,
            description: notifyMsg,
          );
        });
  }
}

class NotifyDialog extends StatelessWidget {
  final String titleText;
  final String description;
  const NotifyDialog({
    Key? key,
    required this.titleText,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: transparentColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: SizedBox(
        height: 215,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 65,
                  decoration: const BoxDecoration(
                    color: blueZodiacColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      titleText,
                      style: titleWhiteTextStyle,
                    ),
                  ),
                ),
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: blueZodiacColor,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  child: CustomText(
                    txtName: description,
                    margin: const EdgeInsets.all(20),
                    style: blueBtnTextStyle,
                    align: TextAlign.center,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBtn(
                primaryColor: blueZodiacColor,
                surfaceColor: blueZodiacColor,
                buttonTestStyle: whiteBtnTextStyle,
                buttonName: okayText,
                buttonMargin:
                    const EdgeInsets.only(top: 15, right: 10, left: 25),
                buttonPadding: EdgeInsets.zero,
                buttonHeight: 45,
                buttonWidth: 100,
                buttonCornerRadius: 6.0,
                buttonBorderColor: blueZodiacColor,
                onPressed: () async {
                  String userid = await LocalStorageService.getId();
                  String customerid = await LocalStorageService.getcustomerId();
                  NotificationReadRequest notify = NotificationReadRequest(
                    customerId: int.parse(customerid),
                    id: int.parse(userid),
                  );
                  customerBlocs.add(GetNotificationReadClickEvent(
                    notifyread: notify,
                  ));
                  navigatorKey.currentState!.pop();
                },
                textScaleFactor: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
