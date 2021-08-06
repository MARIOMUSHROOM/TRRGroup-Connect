import 'package:ai_flutter/auth/animation.dart';
import 'package:ai_flutter/auth/reset_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(ResetPassPage());

class ResetPassPage extends StatefulWidget {
  @override
  ResetPassPageState createState() => ResetPassPageState();
}

class ResetPassPageState extends State<ResetPassPage> {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ResetPassPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "แจ้งลืมรหัสผ่าน",
          style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.6), fontWeight: FontWeight.w700),
        ),
        excludeHeaderSemantics: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/background/grass_purple.png'),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Text(
                      "แจ้งลืมรหัสผ่าน",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                        1.8,
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .3),
                                  blurRadius: 20.0,
                                )
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    icon: const Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
                                        child: const Icon(Icons.recent_actors)),
                                    border: InputBorder.none,
                                    hintText: "เลขประจำตัวประชาชน",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        2,
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(86, 86, 165, 1.0),
                              Color.fromRGBO(58, 64, 141, 0.6)
                            ]),
                          ),
                          child: Center(
                            child: TextButton.icon(
                              icon: Icon(
                                Icons.phonelink_lock,
                                color: Colors.white,
                              ),
                              label: Text("แจ้งลืมรหัสผ่าน",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white)),
                              onPressed: () {
                                Route route = MaterialPageRoute(
                                    builder: (context) => ResetFormPage());
                                Navigator.push(context, route);
                              },
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 0,
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
