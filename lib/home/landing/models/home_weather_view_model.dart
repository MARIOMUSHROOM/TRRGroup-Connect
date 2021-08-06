import 'package:flutter/material.dart';

import '../../../base_class/models/ai_base_model.dart';
import './home_weather_data_model.dart';

class HomeWeatherModelViewItem extends AiBasicItem {
  String topLineData;
  bool isShowWeatherIcon;
  String middleLineText;
  String bottomLineText;

  HomeWeatherModelViewItem({
    this.topLineData = '',
    this.isShowWeatherIcon = true,
    this.middleLineText = '',
    this.bottomLineText = '',
  });

  updateInfo(String aTopLineData, String aMiddleLineText, String aBottomLineText, {bool aIsShowWeatherIcon = true}) {
    this.topLineData = aTopLineData;
    this.middleLineText = aMiddleLineText;
    this.bottomLineText = aBottomLineText;
    this.isShowWeatherIcon = aIsShowWeatherIcon;
  }
}

//--------------------------------------------------------------------------------
class HomeWeatherForecastViewItem extends HomeWeatherModelViewItem {
  HomeWeatherForecastViewItem({
    String iconData,
    String forecastDate,
    String humidity,
  }) : super(
          topLineData: iconData,
          middleLineText: forecastDate,
          bottomLineText: humidity,
          isShowWeatherIcon: true,
        );

  void copyForecastWeatherItem(HomeWeatherForecastItem aForecastDataItem) {
    this.topLineData = aForecastDataItem.weatherIconUrl;
    this.middleLineText = aForecastDataItem.caption;
    this.bottomLineText = '${aForecastDataItem.weatherValueAsIntToString}\u00B0';
  }
}

//--------------------------------------------------------------------------------
class HomeWeatherForecastViewList extends AiBasicList {
  @override
  AiBaseItem getNewObjItem() => HomeWeatherForecastViewItem();

  @override
  List<AiBaseItem> getObjList() => <HomeWeatherForecastViewItem>[];

  List<HomeWeatherForecastViewItem> get days => super.items;

  void addForecastItem(HomeWeatherForecastViewItem aForecastItem) {
    if (aForecastItem != null) days.add(aForecastItem);
  }

  void addForecastItems(List<HomeWeatherForecastViewItem> aForecastItems) {
    aForecastItems.forEach((fItem) {
      this.addForecastItem(fItem);
    });
  }

  void copyForecastWeatherList(HomeWeatherForecastList aForecastDataList) {
    if (aForecastDataList != null && aForecastDataList.isNotEmpty) {
      aForecastDataList.items.forEach((sItem) {
        addForecastItem(HomeWeatherForecastViewItem()..copyForecastWeatherItem(sItem));
      });
    }
  }
}

//--------------------------------------------------------------------------------
class HomeWeatherViewSummary extends HomeWeatherModelViewItem {
  final HomeWeatherModelViewItem _todayData = HomeWeatherModelViewItem();
  final HomeWeatherModelViewItem _rainVolume = HomeWeatherModelViewItem();
  final HomeWeatherModelViewItem _highTempData = HomeWeatherModelViewItem();
  final HomeWeatherModelViewItem _lowTempData = HomeWeatherModelViewItem();
  final HomeWeatherForecastViewList _forecastData = HomeWeatherForecastViewList();

  HomeWeatherViewSummary() {
    isShowWeatherIcon = false;
  }

  HomeWeatherModelViewItem get todayData => _todayData;
  HomeWeatherModelViewItem get rainVolume => _rainVolume;
  HomeWeatherModelViewItem get lowTempData => _lowTempData;
  HomeWeatherModelViewItem get highTempData => _highTempData;
  HomeWeatherForecastViewList get forecastData => _forecastData;

  static final HomeWeatherViewSummary instance = HomeWeatherViewSummary();

  void generateFromWeatherData(HomeWeatherSummaryDataItem aSummaryWeatherObj) {
    if (aSummaryWeatherObj != null) {
      _forecastData.clear();
      var s = aSummaryWeatherObj;
      updateInfo(s.caption, s.weatherValueAsIntToString, s.locationName);

      // _todayData.updateInfo(s.currentDateObj.currentTime, s.currentDateObj.currentThaiDay, s.currentDateObj.currentThaiDateMonth,
      //     aIsShowWeatherIcon: false);
      _rainVolume.updateInfo(s.rainVolumeObj.weatherIconUrl, s.rainVolumeObj.caption, '${s.rainVolumeObj.weatherValueToString} mm');
      _highTempData.updateInfo(s.maxTempObj.weatherIconUrl, s.maxTempObj.caption, '${s.maxTempObj.weatherValueAsIntToString}\u00B0');
      _lowTempData.updateInfo(s.minTempObj.weatherIconUrl, s.minTempObj.caption, '${s.minTempObj.weatherValueAsIntToString}\u00B0');

      _forecastData.copyForecastWeatherList(s.forecastList);
    }
  }
}

// HomeWeatherViewSummary weatherSummary() {
//   // var obj = HomeWeatherViewSummary.instance;
//   var obj = HomeWeatherViewSummary();

//   obj.forecastData.days.clear();
//   obj.updateInfo('เมฆเป็นส่วนมาก', '31', 'กรุงเทพมหานคร');

//   obj.todayData.updateInfo('13:32', 'วันพฤหัสบดี', '27 เมษายน', aIsShowWeatherIcon: false);
//   obj.rainVolume.updateInfo('assets/images/landing/cloudy.png', 'ปริมาณน้ำฝน', '2.2 mm');
//   obj.highTempData.updateInfo('assets/images/landing/sunny.png', 'อุณหภูมิสูงสุด', '33\u00B0');
//   obj.lowTempData.updateInfo('assets/images/landing/raining.png', 'อุณหภูมิต่ำสุด', '23\u00B0');

//   obj.forecastData.addForecastItems(
//     [
//       HomeWeatherForecastViewItem(iconData: 'assets/images/landing/light_rain.png', forecastDate: 'พ.28', humidity: '34%'),
//       HomeWeatherForecastViewItem(iconData: 'assets/images/landing/thunderstrom.png', forecastDate: 'พฤ.29', humidity: '82%'),
//       HomeWeatherForecastViewItem(iconData: 'assets/images/landing/thunderstrom.png', forecastDate: 'ศ.30', humidity: '62%'),
//       HomeWeatherForecastViewItem(iconData: 'assets/images/landing/light_rain.png', forecastDate: 'ส.1', humidity: '48%'),
//       HomeWeatherForecastViewItem(iconData: 'assets/images/landing/light_rain.png', forecastDate: 'อา.2', humidity: '37%'),
//     ],
//   );

//   return obj;
// }

//\u00B0
