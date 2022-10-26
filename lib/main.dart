import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shokuni_customer/blocs/bloc.dart';
import 'package:shokuni_customer/blocs/simple_bloc_observer.dart';
import 'package:shokuni_customer/cache/local_storage.dart';
import 'package:shokuni_customer/pages/home/schedule_page.dart';
import 'package:shokuni_customer/pages/pages.dart';
import 'package:shokuni_customer/services/services.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
String? _notificationTokenId;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  _firebaseMessaging.getToken().then((String? token) async {
    assert(token != null);
    if (token != null) {
      _notificationTokenId = token;
      print("_notificationTokenId $_notificationTokenId");
      final sharedPref = await LocalStorageService.getInstance();
      sharedPref!.setString('fcm_token', _notificationTokenId!);
    } else {}
  });
}

//check user ui.login status
AuthService appAuth = AuthService();
bool result = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  result = await appAuth.checkAlreadyLogin();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(),
        ),
        BlocProvider<CustomerBloc>(
          create: (_) => CustomerBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Shokuni Consumer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        navigatorKey: navigatorKey,
        routes: <String, WidgetBuilder>{
          LoginPage.routeName: (BuildContext _) => const LoginPage(),
          RegisterPage.routeName: (BuildContext _) => const RegisterPage(),
          VerificationPage.routeName: (BuildContext _) =>
              const VerificationPage(),
          PaymentPage.routeName: (BuildContext _) => const PaymentPage(),
          HomePage.routeName: (BuildContext _) => const HomePage(),
          CardPage.routeName: (BuildContext _) => const CardPage(),
          NotificationPage.routeName: (BuildContext _) =>
              const NotificationPage(),
          HistoryPage.routeName: (BuildContext _) => const HistoryPage(),
          PerfectCutPage.routeName: (BuildContext _) => const PerfectCutPage(),
          ForgotPasswordPage.routeName: (BuildContext _) =>
              const ForgotPasswordPage(),
          ForgotPasswordVerify.routeName: (BuildContext _) =>
              const ForgotPasswordVerify(),
          BarberDetailsPage.routeName: (BuildContext _) =>
              const BarberDetailsPage(),
          FinishPage.routeName: (BuildContext _) => const FinishPage(),
          GoogleMaps.routeName: (BuildContext _) => const GoogleMaps(),
          ProfileDetails.routeName: (BuildContext _) => const ProfileDetails(),
          Schedule.routeName: (BuildContext _) => const Schedule(),
          CardsDetailsPage.routeName: (BuildContext _) =>
              const CardsDetailsPage(),
          ChangePasswordPage.routeName: (BuildContext _) =>
              const ChangePasswordPage(),
        },
        onGenerateRoute: (settings) {
          if (result) {
            return MaterialPageRoute(
              builder: (context) {
                return const HomePage();
              },
            );
          } else {
            return MaterialPageRoute(
              builder: (context) {
                return const LoginPage();
              },
            );
          }
        },
        //home: result! ? HomePage() : LoginPage(),

        //   home: const LoginPage(),
      ),
    );
  }
}
