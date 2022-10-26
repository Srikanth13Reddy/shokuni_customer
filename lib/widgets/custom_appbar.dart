import 'package:shokuni_customer/main.dart';
import 'package:shokuni_customer/styles/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double height;
  final String assetIcon;
  final double iconsize;
  final Color bordercolor;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.height,
    required this.assetIcon,
    required this.iconsize,
    required this.bordercolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 200,
        width: double.infinity,
        color: blueZodiacColor,
        padding: const EdgeInsets.only(top: 110),
        child: Text(
          title!,
          style: titleWhiteTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          child: CircleAvatar(
            radius: 47,
            backgroundColor: bordercolor,
            child: CircleAvatar(
              radius: 45,
              backgroundColor: whiteColor,
              child: Image.asset(
                assetIcon,
                height: iconsize,
                width: iconsize,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          onPressed: () => navigatorKey.currentState!.pop(),
          icon: const Icon(
            Icons.clear,
            color: frostColor,
          ),
          padding: const EdgeInsets.only(top: 45, left: 17),
        ),
      ),
    ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
