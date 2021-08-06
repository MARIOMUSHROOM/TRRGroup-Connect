import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingNotifyPage extends StatefulWidget {
  @override
  _SettingNotifyPageState createState() => _SettingNotifyPageState();
}

class _SettingNotifyPageState extends State<SettingNotifyPage> {
  bool seedActivity = false;
  bool sugarcaneQueue = false;
  bool income = false;
  bool weightTractor = false;
  bool radio = false;
  bool book = false;
  bool newpaper = false;
  bool sugarcanePayment = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'ตั้งค่าการแจ้งเตือน',
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              child: ListTile(
                onTap: () {
                  print("next");
                },
                title: Text("กิจกรรมการเพาะปลูก"),
                trailing: Switch(
                  value: seedActivity,
                  onChanged: (value) async {
                    setState(() {
                      seedActivity = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                onTap: () {
                  print("next");
                },
                title: Text("คิวอ้อย"),
                trailing: Switch(
                  value: sugarcaneQueue,
                  onChanged: (value) async {
                    setState(() {
                      sugarcaneQueue = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                onTap: () {
                  print("next");
                },
                title: Text("รายได้"),
                trailing: Switch(
                  value: income,
                  onChanged: (value) async {
                    setState(() {
                      income = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                onTap: () {
                  print("next");
                },
                title: Text("ชั่งรถ"),
                trailing: Switch(
                  value: weightTractor,
                  onChanged: (value) async {
                    setState(() {
                      weightTractor = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                onTap: () {
                  print("next");
                },
                title: Text("วิทยุ"),
                trailing: Switch(
                  value: radio,
                  onChanged: (value) async {
                    setState(() {
                      radio = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                onTap: () {
                  print("next");
                },
                title: Text("วารสาร"),
                trailing: Switch(
                  value: book,
                  onChanged: (value) async {
                    setState(() {
                      book = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                onTap: () {
                  print("next");
                },
                title: Text("ข่าวสาร"),
                trailing: Switch(
                  value: newpaper,
                  onChanged: (value) async {
                    setState(() {
                      newpaper = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                onTap: () {
                  print("next");
                },
                title: Text("เงินค่าออกอ้อย"),
                trailing: Switch(
                  value: sugarcanePayment,
                  onChanged: (value) async {
                    setState(() {
                      sugarcanePayment = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
