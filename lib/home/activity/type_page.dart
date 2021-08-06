import 'package:ai_flutter/home/activity/select_plot_page.dart';
import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:ai_flutter/home/activity/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypePage extends StatefulWidget {
  @override
  _TypePageState createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appBar: AppBar(),
        titleText: 'ประเภทอ้อย',
      ),
      body: Container(
        color: kblueBackgoundColor,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Center(
              child: Text(
                "เลือกประเภทอ้อยที่ต้องการบันทึกกิจกรรม",
                style: TextStyle(
                    // fontSize: 15,
                    ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(2, 3), // changes position of shadow
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SelectPlotPage("อ้อยปลูกใหม่")));
                },
                title: Container(
                  height: 100,
                  // color: Colors.red,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: new BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                            image: new DecorationImage(
                              image: new ExactAssetImage(
                                  'assets/images/activity/Artboard_77.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text("อ้อยปลูกใหม่"),
                        ),
                      ),
                      Expanded(child: Icon(Icons.keyboard_arrow_right))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(2, 3), // changes position of shadow
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectPlotPage("อ้อยตอ")));
                },
                title: Container(
                  height: 100,
                  // color: Colors.red,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: new BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                            image: new DecorationImage(
                              image: new ExactAssetImage(
                                  'assets/images/activity/Artboard_78.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text("อ้อยตอ"),
                        ),
                      ),
                      Expanded(child: Icon(Icons.keyboard_arrow_right))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(2, 3), // changes position of shadow
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectPlotPage("แปลงผสม")));
                },
                title: Container(
                  height: 100,
                  // color: Colors.red,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: new BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                            image: new DecorationImage(
                              image: new ExactAssetImage(
                                  'assets/images/activity/Artboard_80.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text("แปลงผสม"),
                        ),
                      ),
                      Expanded(child: Icon(Icons.keyboard_arrow_right))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
