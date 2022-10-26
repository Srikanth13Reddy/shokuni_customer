import 'package:shokuni_customer/styles/styles.dart';
import 'package:shokuni_customer/utils/utils.dart';

import '../../main.dart';

class Schedule extends StatefulWidget {
  static const String routeName = '/schedule';
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: lightGreyColor,
      body: body(),
    ));
  }

  Widget body() {
    return ListView(children: [
      header(),
    ]);
  }

  Widget header() {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/header.jpeg',
          fit: BoxFit.fitWidth,
          height: 260,
        ),
        IconButton(
            onPressed: () {
              navigatorKey.currentState!.pop();
            },
            icon: const Icon(Icons.clear, color: whiteColor)),
        const SizedBox(
          height: 90,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 180, left: 120),
          child: CircleAvatar(
            radius: 70,
            backgroundColor: whiteColor,
            backgroundImage: AssetImage(
              'assets/images/barber.jpeg',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 330),
          child: Center(
            child: Text(
              'John is ready!',
              style: boldtextStyle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 380),
          child: Center(
            child: Text(
              'The time is yours, step up to the \n'
              '   chair as your barber is ready.',
              style: normaltextStyle,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 450,
          ),
          height: 326,
          width: double.infinity,
          color: whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  " " + promotionText,
                  style: textwithletterspaceStyle,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Card(
                            margin: const EdgeInsets.all(12),
                            shadowColor: whiteColor,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/header.jpeg',
                                  width: 250,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 75),
                                  child: Text(
                                    'The Perfect Cut',
                                    style: textTitlesemiStyle,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, right: 30),
                                  child: Text(
                                    'Jimmy talks about achieving the \n'
                                    'perfect cut',
                                    style: textContentsemiStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 160),
                                  child: TextButton(
                                    child: Text(
                                      'More',
                                      style: textbtnsemiStyle,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
