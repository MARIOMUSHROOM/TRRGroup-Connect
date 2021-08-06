import 'dart:convert';

import 'package:ai_flutter/global_const.dart';
import 'package:ai_flutter/loan/function.dart';
import 'package:ai_flutter/provider/loan_api.dart';
import 'package:ai_flutter/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({Key key}) : super(key: key);

  @override
  _LoanPageState createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  double creditAmount = 0;
  double spentAmount = 0;
  double balance = 0;
  double percent = 0;
  bool isLoading = true;
  bool isLoadError = false;

  getLoanFromAPI() async {
    try {
      var rs = await LoanAPI().getLoan();
      var jsonRes = json.decode(rs.body);
      // print(jsonRes);
      if (jsonRes['result'] == 1) {
        await Future.delayed(Duration(seconds: 2));
        setState(() {
          creditAmount = jsonRes['credit_amount'] == null
              ? null
              : jsonRes["credit_amount"].toDouble();
          spentAmount = jsonRes['spent_amount'] == null
              ? null
              : jsonRes["spent_amount"].toDouble();
          balance =
              jsonRes['balance'] == null ? null : jsonRes["balance"].toDouble();
          // balance = jsonRes['balance'];
          percent = (spentAmount / creditAmount);
          isLoading = false;
          isLoadError = false;
        });
      }
    } catch (e) {
      print(e);
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        isLoading = false;
        isLoadError = true;
      });
    }
  }

  @override
  void initState() {
    getLoanFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "วงเงินสินเชื่อ",
          style: GoogleFonts.kanit(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: kContentColorLightTheme,
        centerTitle: true,
      ),
      body: Container(
        color: kSummaryBgColor,
        height: double.infinity,
        width: double.infinity,
        child: isLoading
            ? Center(
                child: new Container(
                  height: 50,
                  width: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              )
            : isLoadError
                ? Column(
                    children: [
                      Center(
                        child:
                            Text("ไม่สามารถเชื่อมต่อได้กรุณาลองใหม่อีดครั้ง"),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(2, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "ยอดเงินบำรุงทั้งหมด",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    millionNumber(creditAmount),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 35,
                                    ),
                                  ),
                                  Text(
                                    " บาท",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 35,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "วงเงินที่ใช้",
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        millionNumber(spentAmount),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "วงเงินคงเหลือ",
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        millionNumber(balance),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            LinearPercentIndicator(
                              // width: 200,
                              lineHeight: 10.0,
                              percent: percent,
                              backgroundColor: Colors.grey,
                              progressColor: Colors.green,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
      ),
    );
  }
}
