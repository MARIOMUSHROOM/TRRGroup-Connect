import 'package:ai_flutter/auth/animation.dart';
import 'package:ai_flutter/auth/reset_password.dart';
import 'package:ai_flutter/nav_page.dart';
import 'package:ai_flutter/tabs/pages/tabs_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import '../home/landing/pages/top_menu_page.dart';
import '../nav_page.dart';

void main() => runApp(LoginPage());

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => LoginPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/background/fresh_purple.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/objects/light-1.png"),
                                ),
                              ),
                            )),
                      ),
                      Positioned(
                        left: 160,
                        width: 80,
                        height: 120,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/objects/light-2.png"),
                                ),
                              ),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/objects/clock.png"),
                                ),
                              ),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.7,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                            )),
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
                                          child:
                                              const Icon(Icons.recent_actors)),
                                      border: InputBorder.none,
                                      hintText: "เลขประจำตัวประชาชน",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      icon: const Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0.0),
                                          child: const Icon(Icons.lock)),
                                      border: InputBorder.none,
                                      hintText: "รหัสผ่าน",
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
                                  Icons.login,
                                  color: Colors.white,
                                ),
                                label: Text("เข้าสู่ระบบ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.white)),
                                onPressed: () {
                                  Route route = MaterialPageRoute(
                                      // builder: (context) => TabsPage());
                                      builder: (context) => NavPage());
                                  Navigator.push(context, route);
                                },
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 0,
                      ),
                      FadeAnimation(
                          1.5,
                          Container(
                            child: Center(
                              child: TextButton(
                                child: Text("ลืมรหัสผ่าน",
                                    style: TextStyle(
                                        color: Color.fromRGBO(86, 86, 165, 1.0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                onPressed: () {
                                  Route route = MaterialPageRoute(
                                      builder: (context) => ResetPassPage());
                                  Navigator.push(context, route);
                                },
                              ),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
