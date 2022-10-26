import 'package:intl/intl.dart';
import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';

import '../../main.dart';

class PerfectCutPage extends StatefulWidget {
  static const String routeName = '/perfectcut';
  const PerfectCutPage({Key? key}) : super(key: key);

  @override
  _PerfectCutPageState createState() => _PerfectCutPageState();
}

DateTime now = DateTime.now();
String? dateCalender =
    DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY).format(now);

class _PerfectCutPageState extends State<PerfectCutPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGreyColor,
        body: body(),
      ),
    );
  }

  Widget body() {
    return ListView(children: [
      header(),
      leading(),
    ]);
  }

  Widget header() {
    return Stack(children: <Widget>[
      Image.asset(
        'assets/images/header.jpeg',
        fit: BoxFit.fitWidth,
        height: 261,
      ),
      IconButton(
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
          icon: const Icon(Icons.clear, color: whiteColor)),
      const SizedBox(
        height: 90,
      ),
      Container(
        height: 90,
        margin: const EdgeInsets.only(top: 230, left: 60, right: 60),
        child: Card(
          elevation: 5,
          child: ListTile(
            title: Center(
              child: Text(
                perfectCutText,
                style: blackSemitextStyle,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 330, left: 120),
        child: Text(dateCalender!),
      ),
    ]);
  }

  Widget leading() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SizedBox(
        height: 360,
        child: Card(
          elevation: 10,
          child: ListTile(
            title: Text(
              subheadingText,
              style: titleBlueTextStyle,
            ),
            subtitle: Text(
              "Lorem ipsum dolor sit amet , consectetur adipiscing elit.Duisnec dapibus nunc, vel iaculispurus. Nam dignissim est idmetus vulputate luctus.Pellentesque sit amet urna intortor facilisis molestie. Duis seddictum felis. Maecenas tincidunt,lectus a luctus ultrices, mi felisconsequat erat, nec congue nibhrisus vel turpis. Nam elementumrisus leo, sed iaculis risus ",
              style: bluetextnormalStyle,
            ),
          ),
        ),
      ),
    );
  }
}
