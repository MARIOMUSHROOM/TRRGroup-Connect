import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(SugarcaneMapPage());

class SugarcaneMapPage extends StatefulWidget {
  @override
  SugarcaneMapState createState() => SugarcaneMapState();
}

// iframe map //
// class SugarcaneMapState extends State<SugarcaneMapPage> {
//   static Route<dynamic> route() => MaterialPageRoute(
//         builder: (context) => SugarcaneMapPage(),
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: WebView(
//           initialUrl: Uri.dataFromString('<html><body><iframe src="https://www.google.com/maps/d/embed?mid=1wkGg6t8woqbJfZHDXsaF68R0u6uE1Edq" height="100%" width="100%" frameborder="0"></iframe></body></html>', mimeType: 'text/html').toString(),
//           javascriptMode: JavascriptMode.unrestricted,
//         ));
//   }
// }

class SugarcaneMapState extends State<SugarcaneMapPage> {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SugarcaneMapPage(),
      );
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  GoogleMapController controller;

  // List<LatLng> latlngSegment1 = List();
  // List<LatLng> latlngSegment2 = List();
  static LatLng _lat1 = LatLng(13.50092, 100.06569);
  // static LatLng _lat2 = LatLng(13.50053, 100.06246);
  // static LatLng _lat3 = LatLng(13.49686, 100.06411);
  // static LatLng _lat4 = LatLng(13.49738, 100.06719);
  LatLng _lastMapPosition = _lat1;

  @override
  void initState() {
    super.initState();
    //line segment 1
    // latlngSegment1.add(_lat1);
    // latlngSegment1.add(_lat2);
    // latlngSegment1.add(_lat3);
    // latlngSegment1.add(_lat4);
    // latlngSegment1.add(_lat1);

    //line segment 2
    // latlngSegment2.add(_lat4);
    // latlngSegment2.add(_lat5);
    // latlngSegment2.add(_lat6);
    // latlngSegment2.add(_lat1);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        //that needs a list<Polyline>
        polylines: _polyline,

        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(13.50092, 100.06569),
          zoom: 16,
        ),
        mapType: MapType.satellite,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Awesome Polyline tutorial',
          snippet: 'This is a snippet',
        ),
      ));

      _polyline.add(Polyline(
        polylineId: PolylineId('line1'),

        visible: true,
        //latlng is List<LatLng>
        // points: latlngSegment1,
        width: 2,
        color: Colors.redAccent,
      ));
    });
  }
}
