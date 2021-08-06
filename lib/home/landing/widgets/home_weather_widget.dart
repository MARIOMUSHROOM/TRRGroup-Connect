import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'dart:io';
import '../../../basic/pages/trr_basic_page.dart';
import '../../../global_utils.dart' as util;
import '../../../global_const.dart' as cons;

import '../home_const.dart' as homeCons;
import '../models/home_weather_view_model.dart';
import '../../../basic/models/trr_object.dart';

// ignore: must_be_immutable
class HomeWeatherWidget extends TrrBasicPageStatelessWidget {
  final HomeWeatherViewSummary weatherSummary;
  final bool isRetrievingData;

  HomeWeatherWidget(this.weatherSummary, this.isRetrievingData, {Key key, TrrData dataObj}) : super(key: key, dataObj: dataObj);

  Widget _loadingWeather() {
    return Container(
      height: dvHeight * 0.323,
      width: dvWidth,
      child: Align(
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 5,
          ),
        ),
      ),
    );
  }

  @override
  Widget internalBuild(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: dvHeight * 0.038),
          Container(
            decoration: BoxDecoration(
              color: homeCons.kSolidBlueColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            ),
            child: (isRetrievingData)
                ? _loadingWeather()
                : Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                util.horizontalAnimation(HomeCurrentDateTimeBoxContentWidget(),
                                    aStartPosition: 50, aMilliseconds: 1200), // Top left box
                                util.horizontalAnimation(HomeWeatherBoxContentWidget(weatherSummary.rainVolume),
                                    aStartPosition: 50, aMilliseconds: 1400), // Bottom left box
                              ],
                            ),
                            Expanded(child: _currentLocationWeather()),
                            Column(
                              children: [
                                util.horizontalAnimation(HomeWeatherBoxContentWidget(weatherSummary.highTempData),
                                    aStartPosition: -50, aMilliseconds: 1600), // Top right box
                                util.horizontalAnimation(HomeWeatherBoxContentWidget(weatherSummary.lowTempData),
                                    aStartPosition: -50, aMilliseconds: 1800), // Bottom right box
                              ],
                            ),
                          ],
                        ),
                      ),
                      DayWeatherListWidget(weatherSummary.forecastData),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _currentLocationWeather() {
    return util.verticalAnimation(
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              this.weatherSummary.topLineData,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20),
                  Text('${this.weatherSummary.middleLineText}', style: TextStyle(fontSize: 160, color: Colors.white, height: 0.8)),
                  Text('\u00B0', style: TextStyle(fontSize: 80, color: Colors.white, height: 0.1))
                ],
              ),
            ),
            Text(this.weatherSummary.bottomLineText, style: TextStyle(fontSize: 26, color: Colors.white, height: 0.5)),
          ],
        ),
      ),
      aStartPosition: 200,
      aMilliseconds: 1200,
    );
  }
}

//-------------------------------------------------------------------------------------------------------
class HomeCurrentDateTimeBoxContentWidget extends StatelessWidget {
  DateTime get _currentDateTime => DateTime.now();
  String get _currentTime => DateFormat('h:mm').format(_currentDateTime);

  HomeCurrentDateTimeBoxContentWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      height: 80,
      width: 86,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: homeCons.kBlueGreyColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<Object>(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Text(_currentTime, style: TextStyle(fontSize: 32, color: Colors.white, height: 0.8));
              }),
          Text(util.getThaiWeekDayName(_currentDateTime.weekday), style: TextStyle(fontSize: 16, color: Colors.white, height: 0.8)),
          Text('${_currentDateTime.day} ${util.getThaiMonthName(_currentDateTime.month)}',
              style: TextStyle(fontSize: 20, color: Colors.white, height: 0.8)),
        ],
      ),
    );
  }
}

//-------------------------------------------------------------------------------------------------------
class HomeWeatherBoxContentWidget extends StatelessWidget {
  final HomeWeatherModelViewItem weatherObj;

  HomeWeatherBoxContentWidget(this.weatherObj, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      height: 80,
      width: 86,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: homeCons.kBlueGreyColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (weatherObj.isShowWeatherIcon)
              ? Image(image: NetworkImage(weatherObj.topLineData), height: 36, fit: BoxFit.cover)
              : Text(weatherObj.topLineData, style: TextStyle(fontSize: 32, color: Colors.white, height: 0.8)),
          Text(weatherObj.middleLineText, style: TextStyle(fontSize: 16, color: Colors.white, height: 0.8)),
          Text(weatherObj.bottomLineText, style: TextStyle(fontSize: 20, color: Colors.white, height: 0.8)),
        ],
      ),
    );
  }
}

//-------------------------------------------------------------------------------------------------------
// ignore: must_be_immutable
class DayWeatherListWidget extends StatelessWidget {
  final HomeWeatherForecastViewList forecastData;

  DayWeatherListWidget(this.forecastData, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: _dayForecastList(),
      ),
    );
  }

  List<Widget> _dayForecastList() {
    var result = <Widget>[];
    int animStep = 600;
    forecastData.days.map((forecastItem) {
      // Each weather widget
      result.add(
        DayWeatherItemWidget(forecastItem, animMilliSeconds: animStep),
      );

      if (forecastItem != forecastData.days.last) // Vertical divider
        result.add(
          Container(height: 20, child: VerticalDivider(color: Colors.white, thickness: 1)),
        );

      animStep += 300;
    }).toList();
    return result;
  }
}

//-------------------------------------------------------------------------------------------------------
class DayWeatherItemWidget extends StatelessWidget {
  final int animMilliSeconds;
  final HomeWeatherForecastViewItem dayForecastData;

  DayWeatherItemWidget(this.dayForecastData, {Key key, this.animMilliSeconds = 600}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return util.verticalAnimation(
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Image(image: AssetImage(dayForecastData.topLineData), fit: BoxFit.contain, height: 30),
            Image(image: NetworkImage(dayForecastData.topLineData), fit: BoxFit.contain, height: 42),
            Text(dayForecastData.middleLineText, style: TextStyle(color: Colors.white, fontSize: 18, height: 0.9)),
            Text(dayForecastData.bottomLineText, style: TextStyle(color: Colors.white, fontSize: 18, height: 0.8)),
          ],
        ),
      ),
      aMilliseconds: animMilliSeconds,
    );
  }
}
