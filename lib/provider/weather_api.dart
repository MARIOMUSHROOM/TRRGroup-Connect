import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './api_provider.dart';
import './provider_utils.dart' as provUtil;
import '../global_utils.dart' as util;

class WeatherAPI extends ApiProvider {
  static final WeatherAPI instance = WeatherAPI();

  Future<dynamic> getGlobalWeather(double aLatitude, double aLongitude) async {
    // Test latitude 13.832584434687242
    // Test longitude 100.60143961463282
    // https://api.openweathermap.org/data/2.5/onecall?lat=33.07928903367962&lon=132.63378600811185&units=metric&exclude=minutely,hourly,alerts&appid=eb9c1820ca95173afafc7157fbe68b97
    String _globalWeatherUrl =
        // 'https://api.openweathermap.org/data/2.5/onecall?lat=$aLatitude&lon=$aLongitude&units=metric&exclude=alerts&appid=eb9c1820ca95173afafc7157fbe68b97&lang=th';
        'https://api.openweathermap.org/data/2.5/onecall?lat=$aLatitude&lon=$aLongitude&units=metric&exclude=alerts,hourly,minutely&appid=eb9c1820ca95173afafc7157fbe68b97&lang=th';
    return await provUtil.getDataFromAPI(_globalWeatherUrl, this.headers);
  }

  Future<dynamic> getCurrentWeatherLocation(double aLatitude, double aLongitude) async {
    // https://api.openweathermap.org/data/2.5/weather?lat=13.49738&lon=100.06719&appid=9419c93ef58a1c0f8a259650ecac8b89&units=metric&lang=th
    String _currentWeatherUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$aLatitude&lon=$aLongitude&appid=eb9c1820ca95173afafc7157fbe68b97&units=metric&lang=th';
    return await provUtil.getDataFromAPI(_currentWeatherUrl, this.headers);
  }
}
