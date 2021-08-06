import 'package:ai_flutter/home/sugarcane_plot/sugarcane_detail.dart';
import 'package:ai_flutter/home/sugarcane_plot/sugarcane_map.dart';
import 'package:ai_flutter/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(SugarcaneTabsPage());

class SugarcaneTabsPage extends StatefulWidget {
  @override
  SugarcaneTabsState createState() => SugarcaneTabsState();
}

class SugarcaneTabsState extends State<SugarcaneTabsPage> {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SugarcaneTabsPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'ข้อมูลแปลงอ้อย',
            style: GoogleFonts.kanit(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                textStyle: TextStyle(color: Colors.white)),
          ),
          backgroundColor: kPrimaryColor),
      body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.label,
                      // isScrollable: true,
                      indicatorColor: Colors.white,
                      tabs: [
                        Tab(
                            child: Text(
                              'แปลงอ้อย',
                              style: GoogleFonts.kanit(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            icon: Icon(Icons.spa_rounded)),
                        Tab(
                            child: Text(
                              'แปลงอ้อยทั้งหมด',
                              style: GoogleFonts.kanit(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            icon: Icon(Icons.spa_rounded)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                SugarcaneDetailPage(),
                SugarcaneMapPage(),
              ],
            ),
          )),
    );
  }
}

// class SugarcaneDetailState extends State<SugarcaneDetailPage> {
//   static Route<dynamic> route() => MaterialPageRoute(
//     builder: (context) => SugarcaneDetailPage(),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text('กลุ่มบริษัทน้ำตาลไทยรุ่งเรือง'),
//           backgroundColor: Color.fromRGBO(80, 45, 28, 1)),
//       body: DefaultTabController(
//           length: 2,
//           child: Scaffold(
//             appBar: PreferredSize(
//               preferredSize: Size.fromHeight(50.0),
//               child: Column(
//                 children: [
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: TabBar(
//                       labelColor: Colors.black,
//                       unselectedLabelColor: Colors.grey,
//                       indicatorSize: TabBarIndicatorSize.label,
//                       // isScrollable: true,
//                       indicatorColor: Colors.white,
//                       tabs: [
//                         Tab(text: 'กิจกรรม'),
//                         Tab(text: "เกร็ดความรู้"),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             body: TabBarView(
//               children: [
//                 ActivityNews(),
//                 KnowledgeNews(),
//               ],
//             ),
//           )),
//     );
//   }
// }
