import 'dart:io';

import 'package:ai_flutter/home/report/models/agriculture_year_model.dart';
import 'package:flutter/material.dart';
import '../report_const.dart' as rpcons;
import '../report_utils.dart' as rputil;
import './report_plot_list_page.dart';
import './report_plot_detail_page.dart';
import '../models/report_activity_model.dart';
import '../report_test_data.dart';
import '../../../basic/pages/trr_basic_page.dart';

class ReportHomePage extends TrrBasicPageStatefulWidget {
  @override
  _ReportHomePageState createState() => _ReportHomePageState();
}

class _ReportHomePageState extends TrrBasicPageState<ReportHomePage> {
  rpcons.ReportPageType viewType = rpcons.ReportPageType.PlotList;
  BuildContext pageContext;
  ReportPlotItem selectedPlot;

  _onPlotItemTap(ReportPlotItem aReportPlotItem) {
    // print(aReportPlotItem.activityDateList.dateItems[0].activityDateTime);
    selectedPlot = aReportPlotItem;
    // print(selectedPlot.plotName);
    setState(() {
      viewType = rpcons.ReportPageType.PlotActivityDetail;
    });
  }

  _doOnAppBarBackButtonTap() {
    switch (viewType) {
      case rpcons.ReportPageType.PlotActivityDetail:
        setState(() {
          viewType = rpcons.ReportPageType.PlotList;
        });
        break;
      case rpcons.ReportPageType.PlotList:
        Navigator.of(pageContext).pop();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    pageContext = context;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: rpcons.kAppBarColor,
          centerTitle: true,
          title: Text('รายงาน', style: TextStyle(fontSize: 26)),
          automaticallyImplyLeading:
              (viewType == rpcons.ReportPageType.PlotList) ? true : true,
          leadingWidth: 60,
          leading: GestureDetector(
            onTap: _doOnAppBarBackButtonTap,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 15),
                  Icon(
                      (Platform.isIOS)
                          ? Icons.arrow_back_ios_outlined
                          : Icons.arrow_back,
                      size: 28,
                      color: Colors.white),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          child: (viewType == rpcons.ReportPageType.PlotList)
              ? ReportPlotListPage(
                  userPlotList: dummyReportPlotList(),
                  agYearList: AgricultureYearList.getYearList(),
                  onPlotTap: _onPlotItemTap,
                )
              : ReportPlotDetailPage(plotData: selectedPlot),
        ),
      ),
    );
  }
}
