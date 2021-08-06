import 'package:ai_flutter/bloc/report_state/function/check_null.dart';
import 'package:ai_flutter/bloc/report_state/report_detail/bloc/report_detail_bloc.dart';
import 'package:ai_flutter/bloc/report_state/report_list/bloc/report_list_bloc.dart';
import 'package:ai_flutter/global_const.dart';
import 'package:ai_flutter/home/report/models/report_detail_model.dart';
import 'package:ai_flutter/home/report/widgets/app_bar_widget.dart';
import 'package:ai_flutter/home/report/widgets/time_line_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportDetailPage extends StatefulWidget {
  ReportDetailPage({Key key, @required this.idSuccess}) : super(key: key);
  int idSuccess;
  @override
  _ReportDetailPageState createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  ReportDetailModel reportDetailData;
  List<dynamic> dataList = [];
  String title = "";
  Widget widgetBox = SizedBox();
  Widget widgetBoxLazy = SizedBox();
  bool hasMore = true;
  ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  ReportListBloc _reportListBloc;
  ReportDetailBloc _reportDetailBloc;
  @override
  Widget build(BuildContext context) {
    _reportDetailBloc = BlocProvider.of<ReportDetailBloc>(context);
    _reportListBloc = BlocProvider.of<ReportListBloc>(context);
    return BlocBuilder<ReportDetailBloc, ReportDetailState>(
      builder: (context, state) {
        if (state is ReportDetailInitial) {
          _reportDetailBloc.add(LoadReportDetailData(widget.idSuccess));
        } else if (state is ReportDetailNoData) {
          widgetBox = Center(child: Text("ไม่มีข้อมูล"));
        } else if (state is ReportDetailError) {
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
                    _reportDetailBloc
                        .add(LoadReportDetailData(widget.idSuccess));
                  },
                  color: Colors.grey,
                  child: Text("โหลดอีกครั้ง"),
                ),
              ],
            ),
          );
        } else if (state is ReportDetailLazyLoading) {
          widgetBoxLazy = Center(
            child: Container(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ReportDetailLazyLoaded) {
          widgetBoxLazy = Container(
            child: Text(
              "ไม่มีข้อมูลเพิ่มเติม",
              textAlign: TextAlign.center,
            ),
          );
        } else if (state is ReportDetailLoading) {
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
        } else if (state is ReportDetailLoaded) {
          reportDetailData = _reportDetailBloc.reportDetail;
          dataList = _reportDetailBloc.scrollList;
          hasMore = _reportDetailBloc.hasMore;
          title = "แปลงที่ " + dataList[0].plot.toString();
          widgetBox = ListView(
            controller: controller,
            children: [
              Container(
                color: Colors.white,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
              ListViewTimeLineWidget(
                data: dataList,
                onEditClick: (value) async {},
                onDeleteClick: (value) {},
              ),
              widgetBoxLazy,
              SizedBox(
                height: 80,
              )
            ],
          );
        }
        return Scaffold(
          backgroundColor: kPageBackgroundColor,
          appBar: AppBarWidget(
            appBar: AppBar(),
            titleText: "รายงาน",
            actionOn: false,
          ),
          body: Column(
            children: [
              Expanded(child: widgetBox),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
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
                children: [
                  Expanded(
                      child: Text(
                    "ปริมาณอ้อยทั้งหมด",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Text(
                        //   checkNull(reportDetailData.totalAmount),
                        //   textAlign: TextAlign.end,
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        Text(
                          " ตัน",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _scrollListener() async {
    // print(controller.position.extentAfter);
    // print(_scanBloc.pageLimit);
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (hasMore) {
        print(hasMore);
        _reportDetailBloc.add(UpdateOffsetReportDetailData());
      }
    }
  }
}
