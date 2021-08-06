import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../base_class/models/ai_base_model.dart';
import './weather_json_model.dart' as rawWeather;
import './current_weather_json_model.dart' as currentWeather;
import '../home_util.dart' as homeUtil;
import '../../../global_utils.dart' as util;

const kMaxDialyCount = 5;
const kMaxHourlyCount = 24;
const kFirstWeatherIndex = 0;
const kDefaultLowestTemp = 100.0;
const kDefaultHighestTemp = 0.0;

const kMaxTempCaption = 'อุณหภูมิศูงสุด';
const kMinTempCaption = 'อุณหภูมิต่ำสุด';
const kRainVolumeCaption = 'ปริมาณน้ำฝน';

// class HomeWeatherCurrentDateItem extends AiBasicItem {
//   // display current date time
//   // current time, current weekday, current datemonth
//   DateTime _currentDateTime = DateTime.now();
//   String get currentTime => DateFormat('HH:mm').format(DateTime.now());
//   String get currentThaiDay => util.getThaiWeekDayName(_currentDateTime.weekday);
//   String get currentThaiDateMonth => '${_currentDateTime.day} ${util.getThaiMonthName(_currentDateTime.month)}';
// }

//---------------------------------------------------------------------------------------------
class HomeWeatherBasicItem extends AiBasicItem {
  int weatherID;

  String weatherIcon;
  String get weatherIconUrl => 'http://openweathermap.org/img/wn/$weatherIcon.png';

  double weatherValue;
  int get weatherValueAsInt => weatherValue.round();
  String get weatherValueAsIntToString => '$weatherValueAsInt';
  String get weatherValueToString => '$weatherValue';

  @protected
  String weatherCaption = '';
  @protected
  String internalGetCaption() => '';
  String get caption => weatherCaption == '' ? internalGetCaption() : weatherCaption;

  @protected
  bool isValidRawWeatherSource(dynamic aRawWeatherObj) => false;

  @protected
  void internalLoadFromRawWeather(dynamic aRawWeatherObj) {
    clearData();
    // to be implemented
  }

  bool loadFromRawWeather(dynamic aRawWeatherObj) {
    if (aRawWeatherObj != null && isValidRawWeatherSource(aRawWeatherObj)) {
      internalLoadFromRawWeather(aRawWeatherObj);
      return true;
    }
    return false;
  }

  @override
  void internalClearData() {
    weatherID = 0;
    weatherIcon = '';
    weatherValue = 0.0;
  }
}

//---------------------------------------------------------------------------------------------
class HomeWeatherCurrentRainVolume extends HomeWeatherBasicItem {
  // load from toplevelobj.current.rain.1h if exist
  // icon, caption, value
  @override
  String internalGetCaption() => kRainVolumeCaption;

  @override
  bool isValidRawWeatherSource(aRawWeatherObj) => aRawWeatherObj is rawWeather.Current;

  @override
  void internalLoadFromRawWeather(aRawWeatherObj) {
    super.internalLoadFromRawWeather(aRawWeatherObj);

    var currentObj = aRawWeatherObj as rawWeather.Current;
    // check if weather object exist and item count > 0
    if (currentObj.weather != null && currentObj.weather.length > 0) {
      // set weather id and weather icon
      this.weatherID = currentObj.weather[kFirstWeatherIndex].id;
      this.weatherIcon = currentObj.weather[kFirstWeatherIndex].icon;
    }
    // check if rain volumn in current object exist
    this.weatherValue = (currentObj.rain != null) ? currentObj.rain.the1H : this.weatherValue;
  }
}

//---------------------------------------------------------------------------------------------
class HomeWeatherBasicTempItem extends HomeWeatherBasicItem {
  // load from hourly list to find high and low temp
  // icon, caption, value
  @override
  bool isValidRawWeatherSource(aRawWeatherObj) => aRawWeatherObj is currentWeather.CurrentWeatherJsonModel;
  // @override
  // bool isValidRawWeatherSource(aRawWeatherObj) => aRawWeatherObj is List<rawWeather.Current>;
}

//---------------------------------------------------------------------------------------------
class HomeWeatherMinTempItem extends HomeWeatherBasicTempItem {
  @override
  String internalGetCaption() => kMinTempCaption;

  @override
  void internalLoadFromRawWeather(aRawWeatherObj) {
    super.internalLoadFromRawWeather(aRawWeatherObj); // this will clear data first
    var source = aRawWeatherObj as currentWeather.CurrentWeatherJsonModel;
    if (source.isMainDataExist && source.isWeatherListExist) {
      this.weatherID = source.weather[kFirstWeatherIndex].id;
      this.weatherIcon = source.weather[kFirstWeatherIndex].icon;
      this.weatherValue = source.main.tempMin;
    }
  }

  // @override
  // void internalLoadFromRawWeather(aRawWeatherObj) {
  //   super.internalLoadFromRawWeather(aRawWeatherObj);
  //   var hourlyList = aRawWeatherObj as List<rawWeather.Current>;
  //   // finding lowest temp in list
  //   double lowestTemp = kDefaultLowestTemp;
  //   rawWeather.Current lowestItem;
  //   // hourly list is not empty and has at least 24 items
  //   if (hourlyList.isNotEmpty && hourlyList.length >= kMaxHourlyCount) {
  //     // move thourgh first 24 hours
  //     for (var i = 0; i < kMaxHourlyCount; i++) {
  //       if (lowestTemp > hourlyList[i].temp) {
  //         lowestItem = hourlyList[i];
  //         lowestTemp = lowestItem.temp;
  //       }
  //     }
  //     // set to lowest temp to value
  //     if (lowestItem != null && lowestItem.weather != null && lowestItem.weather.length > 0) {
  //       this.weatherValue = lowestItem.temp;
  //       this.weatherID = lowestItem.weather[kFirstWeatherIndex].id;
  //       this.weatherIcon = lowestItem.weather[kFirstWeatherIndex].icon;
  //     }
  //   }
  // }
}

//---------------------------------------------------------------------------------------------
class HomeWeatherMaxTempItem extends HomeWeatherBasicTempItem {
  @override
  String internalGetCaption() => kMaxTempCaption;

  @override
  void internalLoadFromRawWeather(aRawWeatherObj) {
    super.internalLoadFromRawWeather(aRawWeatherObj);
    var source = aRawWeatherObj as currentWeather.CurrentWeatherJsonModel;
    if (source.isMainDataExist && source.isWeatherListExist) {
      this.weatherID = source.weather[kFirstWeatherIndex].id;
      this.weatherIcon = source.weather[kFirstWeatherIndex].icon;
      this.weatherValue = source.main.tempMax;
    }
  }

  // @override
  // void internalLoadFromRawWeather(aRawWeatherObj) {
  //   super.internalLoadFromRawWeather(aRawWeatherObj);
  //   var hourlyList = aRawWeatherObj as List<rawWeather.Current>;
  //   double highestTemp = kDefaultHighestTemp;
  //   rawWeather.Current highestItem;

  //   if (hourlyList.isNotEmpty && hourlyList.length > kMaxHourlyCount) {
  //     for (var i = 0; i < kMaxHourlyCount; i++) {
  //       if (highestTemp < hourlyList[i].temp) {
  //         highestItem = hourlyList[i];
  //         highestTemp = highestItem.temp;
  //       }
  //     }
  //     if (highestItem != null && highestItem.weather != null && highestItem.weather.length > 0) {
  //       this.weatherValue = highestItem.temp;
  //       this.weatherID = highestItem.weather[kFirstWeatherIndex].id;
  //       this.weatherIcon = highestItem.weather[kFirstWeatherIndex].icon;
  //     }
  //   }
  // }
}

//---------------------------------------------------------------------------------------------
class HomeWeatherForecastItem extends HomeWeatherBasicItem {
  // load from toplevelobj.dailylist[i].temp.day
  // icon, caption, value

  @override
  bool isValidRawWeatherSource(aRawWeatherObj) => aRawWeatherObj is rawWeather.Daily;

  @override
  void internalLoadFromRawWeather(aRawWeatherObj) {
    super.internalLoadFromRawWeather(aRawWeatherObj);

    var dailyItem = aRawWeatherObj as rawWeather.Daily;
    // int dateMillis = dailyItem.dt;
    // var date = DateTime.fromMillisecondsSinceEpoch(dateMillis);
    // print(date);
    weatherID = (dailyItem.weather != null && dailyItem.weather.length > 0) ? dailyItem.weather[kFirstWeatherIndex].id : weatherID;
    weatherIcon = (dailyItem.weather != null && dailyItem.weather.length > 0) ? dailyItem.weather[kFirstWeatherIndex].icon : weatherIcon;
    // weatherCaption = '${util.getThaiWeekDayShortName(date.weekday)} ${date.day}';
    weatherValue = (dailyItem.temp != null) ? dailyItem.temp.day : weatherValue;
  }
}

//---------------------------------------------------------------------------------------------
class HomeWeatherForecastList extends AiBasicList {
  // load from toplevelobj.dailylist
  @override
  List<AiBaseItem> getObjList() => <HomeWeatherForecastItem>[];

  @override
  AiBaseItem getNewObjItem() => HomeWeatherForecastItem();

  loadFromDailyList(dynamic aRawDailyList) {
    if (aRawDailyList != null && aRawDailyList is List<rawWeather.Daily> && aRawDailyList.length >= kMaxDialyCount) {
      this.clear();
      // load only first 5 items
      // for (var i = 0; i < kMaxDialyCount; i++) addItem(HomeWeatherForecastItem()..loadFromRawWeather(aRawDailyList[i]));
      HomeWeatherForecastItem newItem;
      DateTime currDate = DateTime.now().add(Duration(days: 1));
      for (var i = 0; i < kMaxDialyCount; i++) {
        newItem = getNewObjItem();
        newItem.loadFromRawWeather(aRawDailyList[i]);
        newItem.weatherCaption = '${util.getThaiWeekDayShortName(currDate.weekday)} ${currDate.day}';
        addItem(newItem);
        currDate = currDate.add(Duration(days: 1));
      }
    }
  }
}

//---------------------------------------------------------------------------------------------
class HomeWeatherSummaryDataItem extends HomeWeatherBasicItem {
  // load from top level object
  // caption, value, locationName
  String locationName;

  // Current Date Object
  // final HomeWeatherCurrentDateItem currentDateObj = HomeWeatherCurrentDateItem();
  // Rain Volumn Object
  final HomeWeatherCurrentRainVolume rainVolumeObj = HomeWeatherCurrentRainVolume();
  // Max Temp Object
  final HomeWeatherMaxTempItem maxTempObj = HomeWeatherMaxTempItem();
  // Min Temp Object
  final HomeWeatherMinTempItem minTempObj = HomeWeatherMinTempItem();
  // Forecast daily list
  final HomeWeatherForecastList forecastList = HomeWeatherForecastList();

  @override
  bool isValidRawWeatherSource(aRawWeatherObj) => (aRawWeatherObj is rawWeather.WeatherJsonModel &&
      aRawWeatherObj.current != null &&
      // aRawWeatherObj.hourly != null &&
      aRawWeatherObj.daily != null);

  @override
  void internalLoadFromRawWeather(aRawWeatherObj) {
    // super.internalLoadFromRawWeather(aRawWeatherObj);
    // cast to json object
    var s = aRawWeatherObj as rawWeather.WeatherJsonModel;

    // Set current temp to object value
    // this.weatherValue = (s.current != null) ? s.current.temp : this.weatherValue;
    // this.locationName = 'กรุงเทพมหานคร';
    // Get caption from weather code
    // if (s.current.weather != null && s.current.weather.length > 0)
    //   this.weatherCaption = homeUtil.weatherCaptionByID(
    //     s.current.weather[kFirstWeatherIndex].id,
    //   );

    // Load rain volume data
    rainVolumeObj.loadFromRawWeather(s.current);
    // Load max temp by finding heighest temp in hourly list
    // maxTempObj.loadFromRawWeather(s.hourly);
    // Load min temp by finding lowest temp in hourly list
    // minTempObj.loadFromRawWeather(s.hourly);
    // Load forecast weather from daily list
    forecastList.loadFromDailyList(s.daily);
  }

  bool translateFromRawWeatherResource(dynamic aRawWeatherObj, currentWeather.CurrentWeatherJsonModel aRawCurrentWeatherObj) {
    if (aRawWeatherObj != null && aRawCurrentWeatherObj != null) {
      var curSource = aRawCurrentWeatherObj;
      if (aRawCurrentWeatherObj.isWeatherListExist && curSource.isMainDataExist) {
        this.weatherID = curSource.weather[kFirstWeatherIndex].id;
        this.weatherIcon = curSource.weather[kFirstWeatherIndex].icon;
        // this.weatherCaption = curSource.weather[kFirstWeatherIndex].description;
        this.weatherValue = curSource.main.temp;
      }
      this.weatherCaption = homeUtil.weatherCaptionByID(this.weatherID);
      this.locationName = curSource.name;

      // load min max temp
      bool tempLoadResult = maxTempObj.loadFromRawWeather(aRawCurrentWeatherObj) && minTempObj.loadFromRawWeather(aRawCurrentWeatherObj);

      return loadFromRawWeather(aRawWeatherObj) && tempLoadResult;
    } else
      return false;
  }
}

//---------------------------------------------------------------------------------------------
