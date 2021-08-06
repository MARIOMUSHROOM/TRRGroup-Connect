import 'package:flutter/material.dart';
import '../../../basic/pages/trr_basic_page.dart';
import '../../../basic/models/trr_object.dart';
import '../../../global_const.dart' as cons;
import '../models/rainfall_plot_model.dart';
import '../widgets/rainfall_plot_item_widget.dart';
import './rainfall_detail_page.dart';

// ignore: must_be_immutable
class RainfallHomePage extends TrrBasicPageStatelessWidget {
  RainfallHomePage({Key key, @required TrrData dataObj}) : super(key: key, dataObj: dataObj);

  int animDuration = 400;

  _doOnPlotItemTapped(RainfallPlotItem selectPlot) {
    if (selectPlot != null)
      Navigator.push(
        pageContext,
        MaterialPageRoute(
          builder: (context) => RainfallDetailPage(dataObj: dataObj, plotItem: selectPlot),
        ),
      );
  }

  @override
  Widget internalBuild(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: cons.kSolidBlueColor,
          title: Text('ปริมาณน้ำฝน', style: TextStyle(fontSize: 26)),
        ),
        body: _rainfallHomePageUI(),
      ),
    );
  }

  Widget _rainfallHomePageUI() {
    var list = dummyPlotList();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      decoration: BoxDecoration(color: cons.kPageBackgroundColor),
      child: GridView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          animDuration += 20;
          if (index == list.length - 1) animDuration = 600;
          return RainfallPlotItemWidget(
            plotItem: list.plotItems[index],
            onPlotTapped: _doOnPlotItemTapped,
            animDuration: animDuration,
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
