import 'package:ai_flutter/auth/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(ResetFormPage());

class ResetFormPage extends StatefulWidget {
  @override
  ResetFormPageState createState() => ResetFormPageState();
}

class ResetFormPageState extends State<ResetFormPage> {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ResetFormPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "เปลี่ยนรหัสผ่าน",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color.fromRGBO(86, 86, 165, 1.0),
        elevation: 0.0,
      ),
      // extendBodyBehindAppBar: true,
      backgroundColor: Color.fromRGBO(86, 86, 165, 0.4),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.8,
                      Card(
                        color: Color.fromRGBO(86, 86, 165, 0.4),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(86, 86, 165, 1.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    icon: const Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
                                        child: const Icon(
                                          Icons.lock_open,
                                          color: Colors.white,
                                        )),
                                    border: InputBorder.none,
                                    hintText: "รหัสผ่านปัจจุบัน",
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(86, 86, 165, 1.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    icon: const Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
                                        child: const Icon(
                                          Icons.lock_open,
                                          color: Colors.white,
                                        )),
                                    border: InputBorder.none,
                                    hintText: "รหัสผ่านไหม่",
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(86, 86, 165, 1.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    icon: const Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
                                        child: const Icon(
                                          Icons.lock_open,
                                          color: Colors.white,
                                        )),
                                    border: InputBorder.none,
                                    hintText: "ยินยันรหัสผ่านอีกครั้ง",
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FadeAnimation(
                                  2,
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromRGBO(586, 86, 165, 1.0)
                                        // gradient: LinearGradient(colors: [
                                        //   Color.fromRGBO(86, 86, 165, 1.0),
                                        //   Color.fromRGBO(58, 64, 141, 0.6)
                                        // ]),
                                        ),
                                    child: Center(
                                      child: TextButton.icon(
                                        icon: Icon(
                                          Icons.vpn_key,
                                          color: Colors.white,
                                        ),
                                        label: Text("เปลี่ยนรหัสผ่าน",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.white)),
                                        onPressed: () {
                                          // Route route = MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         ResetFormPage());
                                          // Navigator.push(context, route);
                                        },
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
