import 'package:ai_flutter/home/activity/type_page.dart';
import 'package:ai_flutter/home/company/contact_us.dart';
import 'package:ai_flutter/home/company/info.dart';
import 'package:ai_flutter/home/journal/journal_page.dart';
import 'package:ai_flutter/home/news/news_list.dart';
import 'package:ai_flutter/home/sugarcane_plot/sugarcane_tabs.dart';
import 'package:ai_flutter/home/weather/weather.dart';
import 'package:ai_flutter/profile/widget/custom_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'queue/pages/queue_home_page.dart';
// import './report/pages/report_home_page.dart';

import '../auth/pages/register_front_page.dart';
import './landing/pages/trr_home_page.dart';
import '../basic/models/trr_object.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomePage(),
      );

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DateTime _focusDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Container(
                //   height: 160,
                //   child: new Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Text('\n\n\n\n\n\n'),
                //       FlutterLogo(
                //         size: 40,
                //       ),
                //       new Container(
                //         margin: EdgeInsets.only(left: 4),
                //         child: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           children: <Widget>[
                //             Text(''),
                //             Text('กลุ่มบริษัทน้ำตาลไทยรุ่งเรือง',
                //                 style: TextStyle(
                //                     fontSize: 20, fontWeight: FontWeight.w600),
                //                 textAlign: TextAlign.center),
                //             Text('สวัสดีคุณ...',
                //                 style: TextStyle(
                //                     fontSize: 16, fontWeight: FontWeight.w600),
                //                 textAlign: TextAlign.right),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('กลุ่มบริษัทน้ำตาลไทยรุ่งเรือง',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                      Text('สวัสดีคุณ...',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.right),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Center(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Text('อุณหภูมิวันนี้',
                                    style: TextStyle(fontSize: 30)))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  Center(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Text('อุณหภูมิวันนี้',
                              style: TextStyle(fontSize: 30)))),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 80,
              child: GridView.count(
                padding: const EdgeInsets.all(20),
                crossAxisCount: 4,
                children: <Widget>[
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon: Image.asset("assets/images/home/company.png"),
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => CompanyInfo());
                        Navigator.push(context, route);
                      },
                    ),
                    Text('ข้อมูลบริษัท',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon:
                          Image.asset("assets/images/home/sugarcane_plot.png"),
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => SugarcaneTabsPage());
                        Navigator.push(context, route);
                      },
                    ),
                    Text('แปลงของฉัน',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon:
                          Image.asset("assets/images/home/record_activity.png"),
                      onPressed: () {
                        print("click");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TypePage()));
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (builder) {
                        //   return TrrHomePage(dataObj: TrrData());
                        // }));
                      },
                    ),
                    Text('บันทึกกิจกรรม',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                        icon: Image.asset("assets/images/home/report.png"),
                        onPressed: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_context) {
                          //   return ReportHomePage();
                          // }));
                        }),
                    Text('รายงาน',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon: Image.asset("assets/images/home/sugarcane.png"),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_context) {
                          return QueueHomePage();
                        }));
                      },
                    ),
                    Text('คิวอ้อย',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon: Image.asset("assets/images/home/qc.png"),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_context) {
                          return RegisterFrontPage();
                        }));
                      },
                    ),
                    Text('ตรวจ CCS',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon: Image.asset("assets/images/home/rainy.png"),
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => WeatherPage());
                        Navigator.push(context, route);
                      },
                    ),
                    Text('น้ำฝน',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon: Image.asset("assets/images/home/contractor.png"),
                      onPressed: () {},
                    ),
                    Text('ผู้รับเหมา',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon: Image.asset("assets/images/home/news.png"),
                      onPressed: () {
                        Route route =
                            MaterialPageRoute(builder: (context) => NewsList());
                        Navigator.push(context, route);
                      },
                    ),
                    Text('ข่าว',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon: Image.asset("assets/images/home/radio.png"),
                      onPressed: () {},
                    ),
                    Text('วิทยุ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon: Image.asset("assets/images/home/journal.png"),
                      onPressed: () {},
                    ),
                    Text('วารสาร',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon: Image.asset("assets/images/home/contact.png"),
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => CompanyContact());
                        Navigator.push(context, route);
                      },
                    ),
                    Text('Contact us',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon: Image.asset("assets/images/home/income.png"),
                      onPressed: () {},
                    ),
                    Text('รายรับ (อ้อย)',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final String subtitle;
  ContentWidget({
    @required this.height,
    @required this.width,
    @required this.title,
    @required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 18),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          subtitle.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
