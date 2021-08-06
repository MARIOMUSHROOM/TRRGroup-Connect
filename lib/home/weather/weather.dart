import 'dart:convert';
// import 'dart:io';

// import 'package:ai_flutter/auth/animation.dart';
import 'package:ai_flutter/home/weather/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(WeatherPage());

class WeatherPage extends StatefulWidget {
  @override
  WeatherState createState() => WeatherState();
}

class WeatherState extends State<WeatherPage> {
  // static Route<dynamic> route() => MaterialPageRoute(
  //       builder: (context) => WeatherPage(),
  //     );

  // var temp;
  // var desc;
  // var rain;
  // var humidity;
  // var windSpeed;
  // var minutes;
  // var date;
  // var month;

  // int temperature;
  // String location = '';
  // int woeid = 11111;
  // String weather = 'clear';
  // String abbreviation = '';
  // String errorMessage = '';

  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  // Position _currentPosition;
  // // String _currentAddress;

  // Future onGetWeather() async {
  //   final param = {
  //     'q': 'Bangkok, TH',
  //     'appid': '9419c93ef58a1c0f8a259650ecac8b89'
  //   };
  //   var uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', param);
  //   final response = await http.get(uri);
  //   var results = jsonDecode(response.body);

  //   setState(() {
  //     this.temp = results['main']['temp'] - 274.15;
  //     this.windSpeed = results['wind']['speed'];
  //     if (results['rain'] == null) {
  //       this.rain = 0;
  //     } else {
  //       this.rain = results['rain']['1h'];
  //     }
  //     this.humidity = results['main']['humidity'];
  //   });

  // }

  // _getCurrentLocation() {
  //   geolocator
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //     _getAddressFromLatLng();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // _getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> p = await geolocator.placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);
  //     Placemark place = p[0];

  //     // setState(() {
  //     //   _currentAddress =
  //     //       "${place.locality}, ${place.postalCode}, ${place.country}";
  //     // });
  //     this.location = place.locality;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   this.onGetWeather();
  //   _getCurrentLocation();
  // }

  Widget build(BuildContext context) {
    //   DateTime now = new DateTime.now();
    //   final dateeng = DateFormat.E().format(now);
    //   final rightNow = new DateTime.now();
    //   this.month = langMonth(rightNow.month);
    //   this.date = langDate(dateeng);
    //   this.minutes = DateFormat.Hm().format(now);

    //   return Scaffold(
    //       appBar: AppBar(
    //         excludeHeaderSemantics: true,
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //         // leading: Icon(Icons.home),
    //         // actions: <Widget>[
    //         //   Padding(
    //         //     padding: EdgeInsets.only(right: 20.0),
    //         //     child: GestureDetector(
    //         //       onTap: () {
    //         //         _getCurrentLocation();
    //         //       },
    //         //       child: Icon(Icons.add_location),
    //         //     ),
    //         //   )
    //         // ],
    //       ),
    //       extendBodyBehindAppBar: true,
    //       backgroundColor: Colors.white,
    //       body: Container(
    //         child: Stack(
    //           children: <Widget>[
    //             Container(
    //               height: double.infinity,
    //               decoration: BoxDecoration(
    //                   image: DecorationImage(
    //                 image: AssetImage('assets/images/background/weather.jpg'),
    //                 fit: BoxFit.cover,
    //               )),
    //             ),
    //             Container(
    //               decoration: BoxDecoration(color: Colors.black38),
    //             ),
    //             Container(
    //               padding: EdgeInsets.only(
    //                   top: 20.0, left: 15.0, bottom: 15.0, right: 15.0),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Expanded(
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             SizedBox(
    //                               height: 100,
    //                             ),
    //                             Text( location != null
    //                                 ? location
    //                                 : "Loading...",
    //                                 style: GoogleFonts.merriweather(
    //                                   fontSize: 36,
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white,
    //                                 )),
    //                             Text(
    //                               minutes +
    //                                   '- ' +
    //                                   date +
    //                                   ', ${now.day} ' +
    //                                   month +
    //                                   ' ${now.year}',
    //                               style: GoogleFonts.merriweather(
    //                                   fontSize: 16,
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white),
    //                             ),
    //                           ],
    //                         ),
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             SizedBox(
    //                               height: 50,
    //                             ),
    //                             Text(
    //                                 temp != null
    //                                     ? temp.toStringAsFixed(0) + '°C'
    //                                     : "Loading...",
    //                                 style: GoogleFonts.merriweather(
    //                                   fontSize: 60,
    //                                   fontWeight: FontWeight.w300,
    //                                   color: Colors.white,
    //                                 )),
    //                             // Row(
    //                             //   children: [
    //                             //     SvgPicture.asset(
    //                             //       'assets/images/weather/moon.svg',
    //                             //       width: 35.0,
    //                             //       height: 35.0,
    //                             //       color: Colors.white,
    //                             //     ),
    //                             //     SizedBox(
    //                             //       width: 10.0,
    //                             //     ),
    //                             //     Text(
    //                             //       'กลางคืน',
    //                             //       style: GoogleFonts.merriweather(
    //                             //           fontSize: 20,
    //                             //           fontWeight: FontWeight.w300,
    //                             //           color: Colors.white),
    //                             //     ),
    //                             //   ],
    //                             // ),
    //                           ],
    //                         )
    //                       ],
    //                       // crossAxisAlignment: CrossAxisAlignment.start,
    //                     ),
    //                   ),
    //                   Column(
    //                     children: [
    //                       Container(
    //                         margin: EdgeInsets.symmetric(vertical: 30),
    //                         decoration: BoxDecoration(
    //                             border: Border.all(
    //                           color: Colors.white30,
    //                         )),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Column(
    //                               children: [
    //                                 Text(
    //                                   'ลม',
    //                                   style: GoogleFonts.merriweather(
    //                                       fontSize: 20,
    //                                       fontWeight: FontWeight.bold,
    //                                       color: Colors.white),
    //                                 ),
    //                                 Text(
    //                                   windSpeed != null
    //                                       ? windSpeed.toString()
    //                                       : "Loading...",
    //                                   style: GoogleFonts.merriweather(
    //                                       fontSize: 20,
    //                                       fontWeight: FontWeight.w300,
    //                                       color: Colors.white),
    //                                 ),
    //                                 Text(
    //                                   'กม./ขม.',
    //                                   style: GoogleFonts.merriweather(
    //                                       fontSize: 20,
    //                                       fontWeight: FontWeight.w300,
    //                                       color: Colors.white),
    //                                 ),
    //                                 Stack(
    //                                   children: [
    //                                     Container(
    //                                       height: 5,
    //                                       width: 50,
    //                                       color: Colors.transparent,
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             ),
    //                             Column(
    //                               children: [
    //                                 Text(
    //                                   'ฝน',
    //                                   style: GoogleFonts.merriweather(
    //                                       fontSize: 20,
    //                                       fontWeight: FontWeight.bold,
    //                                       color: Colors.white),
    //                                 ),
    //                                 Text(
    //                                   rain != null ? rain.toString() : "Loading...",
    //                                   style: GoogleFonts.merriweather(
    //                                       fontSize: 20,
    //                                       fontWeight: FontWeight.w300,
    //                                       color: Colors.white),
    //                                 ),
    //                                 Text(
    //                                   '%',
    //                                   style: GoogleFonts.merriweather(
    //                                       fontSize: 20,
    //                                       fontWeight: FontWeight.w300,
    //                                       color: Colors.white),
    //                                 ),
    //                                 Stack(
    //                                   children: [
    //                                     Container(
    //                                       height: 5,
    //                                       width: 50,
    //                                       color: Colors.transparent,
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             ),
    //                             Column(
    //                               children: [
    //                                 Text(
    //                                   'ความชื้น',
    //                                   style: GoogleFonts.merriweather(
    //                                       fontSize: 20,
    //                                       fontWeight: FontWeight.bold,
    //                                       color: Colors.white),
    //                                 ),
    //                                 Text(
    //                                   humidity != null
    //                                       ? humidity.toString()
    //                                       : "Loading...",
    //                                   style: GoogleFonts.merriweather(
    //                                       fontSize: 20,
    //                                       fontWeight: FontWeight.w300,
    //                                       color: Colors.white),
    //                                 ),
    //                                 Text(
    //                                   '%',
    //                                   style: GoogleFonts.merriweather(
    //                                       fontSize: 20,
    //                                       fontWeight: FontWeight.w300,
    //                                       color: Colors.white),
    //                                 ),
    //                                 Stack(
    //                                   children: [
    //                                     Container(
    //                                       height: 5,
    //                                       width: 50,
    //                                       color: Colors.transparent,
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                       )
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //       );
  }
}
