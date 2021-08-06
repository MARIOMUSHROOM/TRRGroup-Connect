import 'package:ai_flutter/bloc/report_state/report_detail/bloc/report_detail_bloc.dart';
import 'package:ai_flutter/bloc/report_state/report_list/bloc/report_list_bloc.dart';
import 'package:ai_flutter/home/report/models/report_list_model.dart';
import 'package:ai_flutter/home/report/pages/report_detail_page.dart';
import 'package:ai_flutter/home/report/widgets/app_bar_widget.dart';
import 'package:ai_flutter/home/report/widgets/custom_year_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../global_const.dart' as cons;

class ReportPlotListPage extends StatefulWidget {
  const ReportPlotListPage({Key key}) : super(key: key);

  @override
  _ReportPlotListPageState createState() => _ReportPlotListPageState();
}

class _ReportPlotListPageState extends State<ReportPlotListPage> {
  List<ReportDatum> dataList = [];
  String startYear;
  String endYear;
  bool isLoading = false;
  double _height;
  double _width;
  ReportListBloc _reportListBloc;
  @override
  Widget build(BuildContext context) {
    _reportListBloc = BlocProvider.of<ReportListBloc>(context);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return BlocBuilder<ReportListBloc, ReportListState>(
      builder: (context, state) {
        if (state is ReportListInitial) {
          isLoading = true;
          _reportListBloc.add(LoadReportListInitial());
        } else if (state is ReportListLoaded) {
          isLoading = false;
          dataList = _reportListBloc.reportList.reportData;
          startYear = _reportListBloc.startYear;
          endYear = _reportListBloc.endYear;
        } else if (state is ReportListLoading) {
          isLoading = true;
        }
        return Scaffold(
          appBar: AppBarWidget(
            appBar: AppBar(),
            titleText: "รายงาน",
            actionOn: false,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await showPicker();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: cons.kGoldColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$startYear/$endYear"),
                                SizedBox(width: 10),
                                Image(
                                    image: AssetImage(
                                        'assets/images/profile/calendar.png')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 50,
                    // ),
                    Text("เลือกแปลงที่ต้องการ"),
                    Divider(),
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: dataList.length,
                            itemBuilder: (context, index) {
                              ReportDatum only = dataList[index];
                              return Column(
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      BlocProvider.of<ReportDetailBloc>(context)
                                          .add(LoadReportDetailData(
                                              only.idSuccessYear));
                                      var route = MaterialPageRoute(
                                          builder: (context) =>
                                              ReportDetailPage(
                                                idSuccess: only.idSuccessYear,
                                              ));
                                      Navigator.push(context, route);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 5,
                                                decoration: BoxDecoration(
                                                  color: cons.kGoldColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("แปลงที่ "),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(only.plot.toString()),

                                              // Container(
                                              //   height: 0.5,
                                              //   child: Divider(),
                                              // ),
                                            ],
                                          ),
                                          Icon(Icons.keyboard_arrow_right)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                          )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  showPicker() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomYearPickerWidget(
            startYear: DateTime.now().year,
            yearSelect: (value) {
              _reportListBloc.add(UpdateYearReportList(
                  value.toString(), (value + 1).toString()));
            },
          );
        });
  }
}
