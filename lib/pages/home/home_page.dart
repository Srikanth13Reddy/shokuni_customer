import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/cache/local_storage.dart';
import 'package:shokuni_customer/models/model.dart';
import 'package:shokuni_customer/pages/pages.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

import '../../main.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  String latitudesource = '';
  String longitudesource = '';
  LocationData? currentLocation;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
          (location) {
        currentLocation = location;
        latitudesource = currentLocation!.latitude.toString();
        longitudesource = currentLocation!.longitude.toString();
        getlocaldata();
      },
    );

    //getlocaldata();

    /*location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;

        print("what is in latitudesource : $latitudesource");
        print("what is in longitudesource : $longitudesource");

      },
    );*/
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    // getlocaldata();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
  }

  String? accessToken;
  String? username;

  final CustomerBloc customerBlocs = CustomerBloc();

  List<Open> openshoplist = [];
  List<Promotionss> promotiondetails = [];

  void getlocaldata() async {
    username = await LocalStorageService.getName();
    accessToken = await LocalStorageService.getToken();
    setState(() {
      username = username;
    });
    customerBlocs.add(NearByShopClickEvent(latitudesource, longitudesource));
    //customerBlocs.add(NearByShopClickEvent("10.9934702", "77.1027225"));
  }

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var appBarHeight = kToolbarHeight;
    return WillPopScope(
      onWillPop: () async {
        _onCloseApp();
        return shouldPop;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          leading: Text(''),
          title: Text(
            shokuniText,
            style: whiteboldtextStyle,
          ),
          backgroundColor: blueZodiacColor,
        ),
        endDrawer: Padding(
          padding:
          EdgeInsets.fromLTRB(0, statusBarHeight + appBarHeight + 1, 0, 0),
          child: drawerMenu(),
        ),
        body: BlocBuilder<CustomerBloc, CustomerState>(
          bloc: customerBlocs,
          builder: (context, state) {
            if (state is CustomerNearByShopLoaded) {
              openshoplist.clear();
              openshoplist.addAll(state.users.open!);
              promotiondetails.clear();
              promotiondetails.addAll(state.users.promotion!);
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
  Future<void> _refresh() {
    getCurrentLocation();
    return Future.delayed(const Duration(seconds: 0), () {});
  }

  Widget body() {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: ListView(children: [
        map(),
        // dividerCommingsoon(),
        //nearbyShopComming(),
        dividerOpen(),
        nearbyshopOpen(),
      ]),
    );
  }

  Widget map() {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.end,
        expandedAlignment: Alignment.center,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Image.network(
            "https://maps.googleapis.com/maps/api/staticmap?size=700x290&maptype=roadmap%5C&markers=size:mid%7Ccolor:red%7C" +
                latitudesource +
                "," +
                longitudesource +
                "&key=" +
                googlemapapikey,
            height: 100,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        /*trailing: Align(
            alignment: Alignment.center,
            child: Icon(Icons.keyboard_arrow_down, color: blueZodiacColor)),*/
        children: <Widget>[
          GestureDetector(
            onTap: () {
              navigatorKey.currentState!.pushNamed(GoogleMaps.routeName,
                  arguments: ArgumentsLocation(data: currentLocation));
            },
            child: Container(
              margin: const EdgeInsets.only(
                right: 0,
              ),
              height: 300,
              width: 360,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://maps.googleapis.com/maps/api/staticmap?size=700x290&maptype=roadmap%5C&markers=size:mid%7Ccolor:red%7C" +
                          latitudesource +
                          "," +
                          longitudesource +
                          "&key=" +
                          googlemapapikey),
                ),
              ),
            ),
          ), 
        ],
      ),
    );
  }

  Widget dividerCommingsoon() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Expanded(
            child: Divider(
              color: yellowaccent,
              thickness: 1.5,
            ),
          ),
          CustomText(
            margin: const EdgeInsets.all(10),
            txtName: comingSoonText.toUpperCase(),
            style: yellowtextStyle,
            align: TextAlign.center,
          ),
          const Expanded(
            child: Divider(
              color: yellowaccent,
              thickness: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget dividerOpen() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Expanded(
            child: Divider(
              color: Colors.black26,
              thickness: 1.5,
            ),
          ),
          CustomText(
            margin: const EdgeInsets.all(10),
            txtName: openText.toUpperCase(),
            style: blacktextStyle,
            align: TextAlign.center,
          ),
          const Expanded(
            child: Divider(
              color: Colors.black26,
              thickness: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget nearbyshopOpen() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: openshoplist.length,
      itemBuilder: (context, index) {
        return
          GestureDetector(
          onTap: (){
            navigatorKey.currentState!
                .pushNamed(BarberDetailsPage.routeName,
                arguments: Arguments(
                    data: openshoplist[index],
                    promotiondetails: promotiondetails))
                .then((value) => getlocaldata());
          },
          child: Card(
            elevation: 7,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 10),
              leading: Image.network(
                openshoplist[index].headerImage!,
                height: 70,
                width: 70,
              ),
              title: Text(
                openshoplist[index].name!,
                style: normalsemitextStyle,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Table(
                 // mainAxisAlignment: MainAxisAlignment.start,
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                       children: [
                         Row(children: [
                         const ImageIcon(
                           AssetImage("assets/images/location.png"),
                           size: 10,
                         ),
                         Flexible(
                           child: Container(
                             padding: const EdgeInsets.only(left: 6, right: 6),
                             child: Text(openshoplist[index].address!,maxLines: 1, style: textBoxTextStyle,)
                           ),
                         ),
                       ],),
                         Row(children: [
                           const ImageIcon(
                             AssetImage("assets/images/clock.png"),
                             size: 10,
                           ),
                           Flexible(
                             child: Padding(
                               padding: const EdgeInsets.only(left: 6, right: 6),
                               child: Text(openshoplist[index].wait_list.toString(),maxLines: 1, style: textBoxTextStyle,),
                             ),
                           ),
                         ],),
                         Row(children: [
                           const ImageIcon(
                             AssetImage("assets/images/price-tag.png"),
                             size: 10,
                           ),
                           Flexible(
                             child: Padding(
                               padding: const EdgeInsets.only(left: 6),
                               child: Text(
                                 openshoplist[index].priceRange.toString(),
                                 style: textBoxTextStyle,
                                 maxLines: 1,
                               ),
                             ),
                           ),
                         ],)])

                  ],
                ),
              ),
              trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                  color: Colors.black26,
                  iconSize: 20,
                  onPressed: () {
                    navigatorKey.currentState!
                        .pushNamed(BarberDetailsPage.routeName,
                        arguments: Arguments(
                            data: openshoplist[index],
                            promotiondetails: promotiondetails))
                        .then((value) => getlocaldata());
                  }),
            ),
          ),
        );
      },
    );
  }

  Widget nearbyShopComming() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        return Card(
          elevation: 7,
          margin: const EdgeInsets.all(10),
          child: Container(
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              border: Border.all(
                color: yellowaccent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(0),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 10),
              leading: Image.asset("assets/images/payment.png"),
              title: Text(
                "hello",
                style: normalsemitextStyle,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    ImageIcon(
                      AssetImage("assets/images/location.png"),
                      size: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 6, right: 35),
                      child: Text("hello"),
                    ),
                    ImageIcon(
                      AssetImage("assets/images/clock.png"),
                      size: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 6, right: 35),
                        child: Text("hello"),
                      ),
                    ),
                    ImageIcon(
                      AssetImage("assets/images/price-tag.png"),
                      size: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Text("hello"),
                      ),
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                  color: Colors.black26,
                  iconSize: 20,
                  onPressed: () {}),
            ),
          ),
        );
      },
    );
  }

  Widget drawerMenu() {
    return Drawer(
      elevation: 10.0,
      child: Container(
        decoration: const BoxDecoration(
            color: frostdarkColor,
            border: Border(left: BorderSide(width: 2, color: blueZodiacColor))),
        child: Column(children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              // Important: Remove any padding from the ListView.

              children: [
                ListTile(
                  title: Text(
                    'Hi, ${username ?? 'shokuni customer'}',
                    style: normalBlueTitleTextStyle,
                  ),
                  dense: true,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Divider(
                    height: 30,
                    color: Colors.black12,
                    thickness: 1,
                  ),
                ),
                listTileWidget(
                  homeText,
                  "assets/images/home.png",
                      () {
                    navigatorKey.currentState!
                        .pushNamed(PerfectCutPage.routeName);
                  },
                ),
                listTileWidget(
                  historyText,
                  "assets/images/history.png",
                      () {
                    navigatorKey.currentState!.pushNamed(HistoryPage.routeName);
                  },
                ),
                listTileWidget(
                  profileText,
                  "assets/images/user.png",
                      () {
                    navigatorKey.currentState!
                        .pushNamed(ProfileDetails.routeName)
                        .then((value) => getlocaldata());
                  },
                ),
                listTileWidget(
                  changepasswordText,
                  "assets/images/password.png",
                      () {
                    navigatorKey.currentState!
                        .pushNamed(ChangePasswordPage.routeName)
                        .then((value) => getlocaldata());
                  },
                ),
                listTileWidget(
                  notificationText,
                  "assets/images/bell.png",
                      () {
                    navigatorKey.currentState!
                        .pushNamed(NotificationPage.routeName);
                  },
                ),
                listTileWidget(
                  supportText,
                  "assets/images/support.png",
                      () {
                    navigatorKey.currentState!.pushNamed(FinishPage.routeName);
                  },
                ),
                listTileWidget(
                  paymentText,
                  "assets/images/payment.png",
                      () {
                    navigatorKey.currentState!
                        .pushNamed(CardsDetailsPage.routeName);
                  },
                ),
                listTileWidget(
                  settingsText,
                  "assets/images/settings.png",
                      () {},
                ),
                const SizedBox(
                  height: 180,
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          listTileWidget(
            logoutText,
            "assets/images/logout.png",
                () {
              _onLogoutClicked(context);
            },
          ),
        ]),
      ),
    );
  }

  Widget listTileWidget(String title, String image, Function onclick) {
    final listTitle = ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(right: 25),
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset(
          image,
          height: 25,
          color: blueZodiacColor,
          width: 25,
        ),
      ),
      title: Text(
        title,
        style: darkTextStyle,
      ),
      onTap: () => onclick(),
    );
    return listTitle;
  }

  void _onCloseApp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        contentPadding:
        const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 20),
        title: Text(
          areYouSureText,
          style: textBoxTextStyle,
        ),
        content: Text(
          doYouWantLogoutText,
          style: textBoxTextStyle,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextBtn(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                txtName: cancelText,
                btnTestStyle: textBoxTextStyle,
                txtAlign: Alignment.center,
                margin: const EdgeInsets.only(top: 5, bottom: 10),
              ),
              CustomTextBtn(
                onPressed: () async {
                  exit(0);
                },
                txtName: okText,
                btnTestStyle: textBoxTextStyle,
                txtAlign: Alignment.center,
                margin: const EdgeInsets.only(top: 5, bottom: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool shouldPop = true;

  Future<bool>? _onLogoutClicked(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        contentPadding:
        const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 20),
        title: const Text(areYouSureText),
        content: const Text(doYouWantLogoutText),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              cancelText,
              style: textBoxTextStyle,
            ),
          ),
          TextButton(
            onPressed: () async {
              final pref = await LocalStorageService.getInstance();
              pref!.clear();

              navigatorKey.currentState!.pushNamedAndRemoveUntil(
                  LoginPage.routeName, (Route<dynamic> route) => false);
            },
            child: Text(
              okText,
              style: textBoxTextStyle,
            ),
          )
        ],
      ),
    );
  }
}