import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shokuni_customer/styles/styles.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isLoading;
  final Widget widget;

  const LoadingIndicator({
    Key? key,
    required this.isLoading,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      opacity: 0,
      color: Colors.black12,
      isLoading: isLoading,
      progressIndicator: const Align(
        alignment: Alignment.bottomCenter,
        child: SpinKitThreeBounce(
          color: roseColor,
          size: 40,
        ),
      ),
      child: widget,
    );
  }
}
