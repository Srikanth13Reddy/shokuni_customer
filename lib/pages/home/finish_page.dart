import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';
import 'package:shokuni_customer/widgets/widgets.dart';

class FinishPage extends StatefulWidget {
  static const String routeName = '/finish';
  const FinishPage({Key? key}) : super(key: key);

  @override
  _FinishPageState createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: Text(
            shokuniText,
            style: whiteboldtextStyle,
          ),
          backgroundColor: blueZodiacColor,
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    return ListView(children: [
      Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        height: 60,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/map-background.jpg"),
          ),
        ),
      ),
      cutfinish(),
      jamesdixon()
    ]);
  }

  Widget cutfinish() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: riverBedBlueColor, width: 1),
      ),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      height: 280,
      width: 350,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Image.asset(
              "assets/images/balloons.png",
              color: riverBedBlueColor,
              height: 120,
              width: 120,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Text(
              cutFinishText.toUpperCase(),
              style: blueboldtextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              cutFinish1Text,
              style: bluesemitextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              cutFinish2Text,
              style: bluesemitextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              cutFinish3Text,
              style: bluesemitextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget jamesdixon() {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: riverBedBlueColor, width: 1),
        ),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        height: 240,
        width: 350,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text(
                'JAMES DIXON',
                style: bluesemiboldtextStyle,
              )),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              height: 4,
              thickness: 1.5,
            ),
          ),
          ListTile(
            title: Text(
              customerInvoiceText,
              style: bluesemimediumtextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 100),
            child: Text(
              "- Shampoo & Cut .................12",
              style: normaltextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 100, top: 10),
            child: Text(
              "- Hot Towel Shave................6",
              style: normaltextStyle,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Divider(
              thickness: 1.5,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 150),
            child: Text(
              "total: \u{20B9}11",
              style: normaltextStyle,
            ),
          ),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 120, top: 240, right: 120),
        child: SizedBox(
          height: 40,
          width: 150,
          child: CustomBtn(
            primaryColor: riverBedBlueColor,
            surfaceColor: riverBedBlueColor,
            buttonTestStyle: whiteBtnTextStyle,
            buttonName: finishText.toUpperCase(),
            buttonMargin: const EdgeInsets.only(),
            buttonPadding: EdgeInsets.zero,
            buttonHeight: 50,
            buttonWidth: 120,
            buttonCornerRadius: 0,
            buttonBorderColor: roseColor,
            onPressed: () {
              {}
            },
            textScaleFactor: 1.0,
          ),
        ),
      ),
    ]);
  }
}
