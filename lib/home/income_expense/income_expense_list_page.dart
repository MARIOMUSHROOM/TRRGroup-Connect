import 'package:ai_flutter/bloc/income_expense_state/receipt_cane_info/bloc/receipt_cane_info_bloc.dart';
import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:ai_flutter/home/income_expense/function.dart';
import 'package:ai_flutter/home/income_expense/model/receipt_cane_model.dart';
import 'package:ai_flutter/home/income_expense/widget/border_decoration_custom.dart';
import 'package:ai_flutter/home/income_expense/widget/custom_year_picker.dart';
import 'package:ai_flutter/home/income_expense/widget/divider_custom_widget.dart';
import 'package:ai_flutter/home/income_expense/widget/pick_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class IncomeExpenseListPage extends StatefulWidget {
  const IncomeExpenseListPage({Key key}) : super(key: key);

  @override
  _IncomeExpenseListPageState createState() => _IncomeExpenseListPageState();
}

class _IncomeExpenseListPageState extends State<IncomeExpenseListPage> {
  List selectList = ["งวดที่ 1", "งวดที่ 2", "งวดที่ 3"];
  String selectedStation = "งวดที่ 1";
  Widget widgetBox = SizedBox();
  DateTime initialDate = DateTime.now();
  int initialPlot = 1;
  ReceiptCaneModel receiptCaneData;
  ReceiptCaneInfoBloc _receiptCaneInfoBloc;
  @override
  Widget build(BuildContext context) {
    _receiptCaneInfoBloc = BlocProvider.of<ReceiptCaneInfoBloc>(context);
    return BlocBuilder<ReceiptCaneInfoBloc, ReceiptCaneInfoState>(
      builder: (context, state) {
        if (state is ReceiptCaneInfoInitial) {
          _receiptCaneInfoBloc.add(LoadReceiptCaneInitial());
        } else if (state is ReceiptCaneInfoNoData) {
          widgetBox = Column(
            children: [
              Text("ไม่มีข้อมูล"),
            ],
          );
        } else if (state is ReceiptCaneInfoError) {
          widgetBox = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ไม่สามารถทำรายการได้ กรุณาลองใหม่อีกครั้ง : ",
                  maxLines: 10,
                ),
                FlatButton(
                  onPressed: () {
                    _receiptCaneInfoBloc.add(LoadReceiptCaneInitial());
                  },
                  color: Colors.grey,
                  child: Text("โหลดอีกครั้ง"),
                ),
              ],
            ),
          );
        } else if (state is ReceiptCaneInfoLoading) {
          widgetBox = Column(
            children: [
              Center(
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
              ),
              new Center(child: Text("Loading...")),
            ],
          );
        } else if (state is ReceiptCaneInfoLoaded) {
          receiptCaneData = _receiptCaneInfoBloc.receiptCaneModel;
          initialDate = _receiptCaneInfoBloc.selectedDate;
          // print(receiptCaneData.installmentList[0]);
          widgetBox = ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: receiptCaneData.installmentList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(minHeight: 200),
                      decoration: BorderDecorationCustom.shadow(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints:
                                BoxConstraints(minWidth: double.infinity),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              children: [
                                Text(
                                  "งวดที่",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  receiptCaneData
                                      .installmentList[index].installmentNo
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "วันที่",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  formatDate(receiptCaneData
                                      .installmentList[index].beginDate),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "ถึง",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  formatDate(receiptCaneData
                                      .installmentList[index].endDate),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          WhiteCardWidget(
                              index: index, receiptCaneData: receiptCaneData),
                          receiptCaneData
                                  .installmentList[index].paymentList.isEmpty
                              ? Container(
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                )
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: receiptCaneData
                                      .installmentList[index]
                                      .paymentList
                                      .length,
                                  itemBuilder: (context, indexTwo) {
                                    return GreenCardWidget(
                                      index: index,
                                      indexTwo: indexTwo,
                                      receiptCaneData: receiptCaneData,
                                    );
                                  }),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              });
        }
        return ListView(
          padding: EdgeInsets.all(8),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 150,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kGoldColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _selectDate(context);
                        },
                        child: Row(
                          children: [
                            Text(
                              DateFormat('MMMM yyyy', 'th_TH')
                                  .format(initialDate)
                                  .toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: 100,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    value: selectedStation,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.black)),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        selectedStation = newValue;
                      });
                    },
                    items: selectList.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            widgetBox
          ],
        );
      },
    );
  }

  showPicker() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PickTime(
            startDate: DateTime.now(),
            endDate: DateTime.now(),
            focusedStartDay: (value) {},
            focusedLastDay: (value) {},
          );
        });
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 20),
        lastDate: DateTime.now(),
        locale: const Locale("th", "TH"),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.blue,
                onPrimary: Colors.white,
                surface: Colors.grey,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _receiptCaneInfoBloc.add(UpdateDateReceiptCane(newSelectedDate));
      // focusedStartDay(newSelectedDate);
    }
  }
}

class GreenCardWidget extends StatelessWidget {
  const GreenCardWidget({
    Key key,
    @required this.index,
    @required this.indexTwo,
    @required this.receiptCaneData,
  }) : super(key: key);
  final int index;
  final int indexTwo;
  final ReceiptCaneModel receiptCaneData;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: double.infinity),
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          TitleWithContentExpandedTextWidget(
            title: receiptCaneData
                .installmentList[index].paymentList[indexTwo].paymentType
                .toString(),
            textColor: Colors.white,
          ),
          DividerCustomWidget(),
          TitleWithContentTextWidget(
            title: "เลขที่",
            content: receiptCaneData
                .installmentList[index].paymentList[indexTwo].referenceNo
                .toString(),
            textColor: Colors.white,
          ),
          DividerCustomWidget(),
          TitleWithContentTextWidget(
            title: "สาขา",
            content: receiptCaneData
                .installmentList[index].paymentList[indexTwo].bankBranch
                .toString(),
            textColor: Colors.white,
          ),
          DividerCustomWidget(),
          TitleWithContentTextWidget(
            title: "ลงวันที่",
            content: formatDate(receiptCaneData
                .installmentList[index].paymentList[indexTwo].chequeDate),
            textColor: Colors.white,
          ),
          DividerCustomWidget(),
          TitleWithContentExpandedTextWidget(
            title: "จำนวนเงิน",
            content: millionNumber(receiptCaneData
                .installmentList[index].paymentList[indexTwo].paymentTotal),
            bit: "บาท",
            focusTitle: true,
            textColor: Colors.white,
          ),
          DividerCustomWidget(thickness: 2),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class WhiteCardWidget extends StatelessWidget {
  const WhiteCardWidget({
    Key key,
    @required this.index,
    @required this.receiptCaneData,
  }) : super(key: key);
  final int index;
  final ReceiptCaneModel receiptCaneData;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: double.infinity),
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWithContentTextWidget(
            title: "วันที่",
            content: formatDate(
                receiptCaneData.installmentList[index].installmentDate),
          ),
          DividerCustomWidget(),
          TitleWithContentTextWidget(
            title: "ขายอ้อยให้แก่บริษัท",
            content:
                millionNumber(receiptCaneData.installmentList[index].saleTo),
          ),
          DividerCustomWidget(),
          TitleWithContentTextWidget(
            title: "สาขา",
            content:
                millionNumber(receiptCaneData.installmentList[index].branch),
          ),
          DividerCustomWidget(),
          TitleWithContentTextWidget(
            title: "เลขประจำตัวผู้เสียภาษี",
            content:
                millionNumber(receiptCaneData.installmentList[index].taxId),
          ),
          DividerCustomWidget(),
          SizedBox(
            height: 20,
          ),
          TitleWithContentExpandedTextWidget(
            title: "น้ำหนักอ้อย",
            content: millionNumber(
                    receiptCaneData.installmentList[index].sugarcaneWeight)
                .toString(),
            bit: "ตัน",
          ),
          DividerCustomWidget(),
          TitleWithContentExpandedTextWidget(
            title: "คิดเป็นเงิน",
            content:
                millionNumber(receiptCaneData.installmentList[index].income),
            bit: "บาท",
          ),
          DividerCustomWidget(),
          TitleWithContentExpandedTextWidget(
            title: "หักค่าใช้จ่าย",
            content: millionNumber(
                receiptCaneData.installmentList[index].expenseSum),
            bit: "บาท",
          ),
          DividerCustomWidget(),
          TitleWithContentExpandedTextWidget(
            title: "หักชำระหนี้",
            content: millionNumber(
                receiptCaneData.installmentList[index].deptDecreaseSum),
            bit: "บาท",
          ),
          DividerCustomWidget(),
          TitleWithContentExpandedTextWidget(
            title: "คงเหลือสุทธิ",
            content:
                millionNumber(receiptCaneData.installmentList[index].balance),
            bit: "บาท",
            focusTitle: true,
            contentTextColor: Colors.green,
          ),
          DividerCustomWidget(thickness: 2),
          SizedBox(
            height: 20,
          ),
          TitleWithContentExpandedTextWidget(
            title: "ยอดอ้อยสะสม",
            content: millionNumber(receiptCaneData
                .installmentList[index].cumulativeSugarcaneAmount),
            bit: "ตัน",
          ),
          DividerCustomWidget(),
          TitleWithContentExpandedTextWidget(
            title: "ยอดอ้อยสด งวดนี้",
            content: millionNumber(
                receiptCaneData.installmentList[index].freshSugarcaneAmount),
            bit: "ตัน",
          ),
          DividerCustomWidget(),
          TitleWithContentExpandedTextWidget(
            title: "ยอดอ้อยไฟไหม้ งวดนี้",
            content: millionNumber(
                receiptCaneData.installmentList[index].burnSugarcaneAmount),
            bit: "ตัน",
          ),
          DividerCustomWidget(),
          TitleWithContentExpandedTextWidget(
            title: "ยอดหนี้คงเหลือทั้งสิน",
            content: millionNumber(
                receiptCaneData.installmentList[index].deptAmount),
            bit: "บาท",
            focusTitle: true,
            contentTextColor: Colors.red,
          ),
          DividerCustomWidget(thickness: 2),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class TitleWithContentTextWidget extends StatelessWidget {
  TitleWithContentTextWidget({
    Key key,
    @required this.title,
    @required this.content,
    this.textColor,
  }) : super(key: key);
  String title;
  String content;
  Color textColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title + " : ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        Text(
          content,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ],
    );
  }
}

class TitleWithContentExpandedTextWidget extends StatelessWidget {
  TitleWithContentExpandedTextWidget({
    Key key,
    @required this.title,
    this.content,
    this.focusTitle = false,
    this.bit,
    this.textColor,
    this.contentTextColor,
  }) : super(key: key);
  String title;
  String content;
  bool focusTitle;
  String bit;
  Color textColor;
  Color contentTextColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: focusTitle ? FontWeight.bold : FontWeight.normal,
              color: textColor,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        content == null
            ? SizedBox()
            : Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      content,
                      style: TextStyle(
                        color: contentTextColor == null
                            ? textColor
                            : contentTextColor,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    bit == null
                        ? SizedBox()
                        : Text(
                            "  " + bit,
                            style: TextStyle(
                              color: contentTextColor == null
                                  ? textColor
                                  : contentTextColor,
                            ),
                            textAlign: TextAlign.end,
                          ),
                  ],
                ),
              ),
      ],
    );
  }
}
