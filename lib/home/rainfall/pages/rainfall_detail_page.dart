import 'package:flutter/material.dart';
import '../../../basic/pages/trr_basic_page.dart';
import '../../../basic/models/trr_object.dart';
import '../models/rainfall_plot_model.dart';
import '../../../global_const.dart' as cons;
import '../../../global_utils.dart' as util;

// ignore: must_be_immutable
class RainfallDetailPage extends TrrBasicPageStatelessWidget {
  final RainfallPlotItem plotItem;
  RainfallDetailPage({Key key, @required TrrData dataObj, @required this.plotItem}) : super(key: key, dataObj: dataObj);

  @override
  Widget internalBuild(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cons.kPageBackgroundColor,
        appBar: AppBar(
          backgroundColor: cons.kSolidBlueColor,
          title: Text('แปลงที่ ${plotItem.plotNumber}', style: TextStyle(fontSize: 26)),
        ),
        body: _rainfallDetailPageUI(),
      ),
    );
  }

  Widget _rainfallDetailPageUI() {
    return SingleChildScrollView(
      child: Container(
        color: cons.kPageBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rainfallSummary(),
            _rainfallYearlyDetail(),
          ],
        ),
      ),
    );
  }

  Widget _rainfallSummary() {
    // String displayDate = DateFormat('EEEE d MMMM yyyy', 'th').format(util.getThaiDateTime(DateTime.now()));
    var displayDate = util.getFullThaiDateFormat(DateTime.now());
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(offset: Offset(0, 5), color: Colors.blueGrey[100], blurRadius: 20)],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: cons.kSolidBlueColor,
      ),
      child: Column(
        children: [
          Text('ปริมาณน้ำฝน', style: TextStyle(fontSize: 30, color: Colors.white, height: 0.8)),
          Text('$displayDate', style: TextStyle(fontSize: 24, color: Colors.white)),
          Container(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 85,
                          height: 75,
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: cons.kBlueGreyColor),
                          child: Image.asset('assets/images/rainfall/rainfall.png', fit: BoxFit.contain),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text('${plotItem.rainfall.toStringAsFixed(1)}', style: TextStyle(fontSize: 110, color: Colors.white, height: 0.95)),
                            Text(' มม.', style: TextStyle(fontSize: 24, color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                RainfallChanceOfRainWidget(plotItem: this.plotItem),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Expanded(
                  child: RainfallDetailImageBoxWidget(
                    iconImage: 'assets/images/rainfall/relative_humidity.png',
                    value: '${plotItem.relativeHumidity} %',
                    label: 'ความชื้น',
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                    child: RainfallDetailImageBoxWidget(
                  iconImage: 'assets/images/rainfall/dew_point.png',
                  value: '${plotItem.dewPoint} \u00B0',
                  label: 'จุดความชื้น',
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rainfallYearlyDetail() {
    return Container(
      height: dvHeight * 0.50,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text('ปริมาณน้ำฝนสะสม', style: TextStyle(fontSize: 26, color: cons.kSolidBlueColor)),
          ),
          RainfallYearlyDetailCardWidget(),
          RainfallYearlyDetailCardWidget(),
        ],
      ),
    );
  }
}

class RainfallYearlyDetailCardWidget extends StatelessWidget {
  const RainfallYearlyDetailCardWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.only(top: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('ปีปัจจุบัน'),
            Text('585.7 mm', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            Image.asset('assets/images/rainfall/rainfall_current_year.png'),
          ],
        ),
      ),
    );
  }
}

class RainfallChanceOfRainWidget extends StatelessWidget {
  final RainfallPlotItem plotItem;

  const RainfallChanceOfRainWidget({Key key, @required this.plotItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 75,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: cons.kBlueGreyColor),
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('${plotItem.chanceOfRain} %', style: TextStyle(color: Colors.white, fontSize: 40, height: 0.8)),
            Text('โอกาส', style: TextStyle(color: Colors.white, fontSize: 24, height: 0.8)),
          ],
        ),
      ),
    );
  }
}

class RainfallDetailImageBoxWidget extends StatelessWidget {
  final String iconImage;
  final String value;
  final String label;
  const RainfallDetailImageBoxWidget({
    Key key,
    @required this.iconImage,
    @required this.value,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cons.kBlueGreyColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(iconImage, fit: BoxFit.contain),
          SizedBox(width: 5),
          Container(
              child: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: TextStyle(color: Colors.white, fontSize: 30, height: 0.8)),
                SizedBox(height: 5),
                Text(label, style: TextStyle(color: Colors.white, fontSize: 26, height: 0.8)),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
