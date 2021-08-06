import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(SugarcaneDetailPage());

class SugarcaneDetailPage extends StatefulWidget {
  @override
  SugarcaneDetailState createState() => SugarcaneDetailState();
}

class SugarcaneDetailState extends State<SugarcaneDetailPage> {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SugarcaneDetailPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          height: MediaQuery.of(context).size.height - 200,
          child: ListView(
            children: <Widget>[
              _buildListItem('assets/images/cards/pastel_card_01.jpg', 'Japan',
                  'Explore the land of Wano'),
              _buildListItem('assets/images/cards/pastel_card_01.jpg', 'Japan',
                  'Explore the land of Wano'),
              _buildListItem('assets/images/cards/pastel_card_01.jpg', 'Japan',
                  'Explore the land of Wano'),
              _buildListItem('assets/images/cards/pastel_card_01.jpg', 'Japan',
                  'Explore the land of Wano')
            ],
          ),
        ),
      ],
    );
  }

  _buildListItem(String imgPath, String country, String description) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
          ),
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(imgPath),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.darken),
              ),
            ),
          ),
          Container(
            height: 200.0,
            child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ปี : 64/65 , แปลง : 1 , พื้นที่ 51.9',
                    style: GoogleFonts.kanit(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        textStyle: TextStyle(color: Colors.white)),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'อายุอ้อย : 3',
                    style: GoogleFonts.kanit(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        textStyle: TextStyle(color: Colors.white)),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'พันธุ์อ้อย : ขอนแก่น',
                    style: GoogleFonts.kanit(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        textStyle: TextStyle(color: Colors.white)),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'ผลผลิตตัน/ไร่ 4.5 ตัน รวม 233.55 ตัน',
                    style: GoogleFonts.kanit(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        textStyle: TextStyle(color: Colors.white)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 50),
                          child: TextButton.icon(
                            icon: Icon(
                              Icons.build_circle,
                              color: Colors.white,
                            ),
                            label: Text(
                              "การบำรุงรักษา",
                              style: GoogleFonts.kanit(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  textStyle: TextStyle(color: Colors.white)),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 0),
                          child: TextButton.icon(
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            label: Text(
                              "แผนที่รูปแปลง",
                              style: GoogleFonts.kanit(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  textStyle: TextStyle(color: Colors.white)),
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
