import 'dart:ui';

import 'package:shokuni_customer/styles/styles.dart';

class BackGroundImageWidget extends StatelessWidget {
  final String imagepath;
  final Widget body;

  const BackGroundImageWidget(
      {Key? key, required this.imagepath, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagepath), fit: BoxFit.cover),
      ),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), child: body),
    );
  }
}
