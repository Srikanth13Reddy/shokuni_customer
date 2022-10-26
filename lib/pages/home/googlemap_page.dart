import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shokuni_customer/styles/styles.dart';

import '../../widgets/widgets.dart';

class GoogleMaps extends StatefulWidget {
  static const String routeName = '/map';
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class ArgumentsLocation {
  final LocationData? data;

  ArgumentsLocation({
    this.data,
  });
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer();

  LocationData? currentLocation;
  late ArgumentsLocation args;

  void initState() {
    //getPolyPoints();
    getCurrentLocation();
    print("what is in currentLocation : $currentLocation ");
    super.initState();
  }

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    /*  GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
      },
    );*/
    /*setState(() {
      print("what is in currentLocation : $currentLocation ");
    });*/
  }

  static const LatLng _center = LatLng(45.521563, -122.677433);

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    args = ModalRoute.of(context)!.settings.arguments as ArgumentsLocation;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: args == null
          ? LoadingIndicator(
              isLoading: true,
              widget: SizedBox(),
            )
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(args.data!.latitude!, args.data!.longitude!),
                zoom: 13.5,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: LatLng(args.data!.latitude!, args.data!.longitude!),
                ),
              },
            ),
    );
  }
}
