import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:ai_flutter/home/income_expense/income_expense_info_page.dart';
import 'package:ai_flutter/home/income_expense/income_expense_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IncomeExpenseTabPage extends StatefulWidget {
  const IncomeExpenseTabPage({Key key}) : super(key: key);

  @override
  _IncomeExpenseTabPageState createState() => _IncomeExpenseTabPageState();
}

class _IncomeExpenseTabPageState extends State<IncomeExpenseTabPage> {
  int indexSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "รายรับ-รายจ่าย",
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
        ),
        centerTitle: true,
      ),
      // appBar: AppBarWidget(
      //   appBar: AppBar(),
      //   titleText: _inputActivityForm.activity_type,
      //   actionOn: false,
      //   // onPressed: () async {
      //   //   await submitData();
      //   // },
      // ),
      body: DefaultTabController(
        length: 2,
        child: Builder(builder: (context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              setState(() {
                indexSelected = tabController.index;
              });
              print(indexSelected);
            }
          });
          return Column(
            children: <Widget>[
              Container(
                // color: Colors.green,
                constraints: BoxConstraints.expand(height: 50),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     spreadRadius: 5,
                  //     blurRadius: 7,
                  //     offset: Offset(0, 3), // changes position of shadow
                  //   ),
                  // ],
                ),
                child: Container(
                  color: Colors.grey[200],
                  child: TabBar(
                    controller: tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    labelPadding: EdgeInsets.all(4),
                    tabs: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: tabController.index == 0
                              ? kGoldColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "รายรับรายจ่ายทั้งหมด",
                          style: TextStyle(
                            fontSize: 22,
                            color: tabController.index == 0
                                ? Colors.white
                                : kGoldColor,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: tabController.index == 1
                              ? kGoldColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "รายได้จากค่าอ้อย",
                          style: TextStyle(
                            fontSize: 22,
                            color: tabController.index == 1
                                ? Colors.white
                                : kGoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    children: [
                      IncomeExpenseInfoPage(),
                      IncomeExpenseListPage(),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
