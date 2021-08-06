import 'dart:async';
import 'package:ai_flutter/home/landing/models/home_weather_view_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../provider/weather_api.dart';
import '../../../home/landing/models/weather_json_model.dart';
import '../../../home/landing/models/current_weather_json_model.dart';
import '../../../home/landing/models/home_weather_data_model.dart';

part 'global_weather_event.dart';
part 'global_weather_state.dart';

class GlobalWeatherBloc extends Bloc<GlobalWeatherEvent, GlobalWeatherState> {
  GlobalWeatherBloc() : super(GlobalWeatherInitial());

  final WeatherAPI _weatherAPI = WeatherAPI.instance;
  final HomeWeatherSummaryDataItem homeWeatherDataObj = HomeWeatherSummaryDataItem();

  @override
  Stream<GlobalWeatherState> mapEventToState(
    GlobalWeatherEvent event,
  ) async* {
    if (event is GlobalWeatherRetrieveDataEvent) yield* _getGlobalWeather(event.latitude, event.longitude);
  }

  Stream<GlobalWeatherState> _getGlobalWeather(double aLatitude, double aLongitude) async* {
    yield GlobalWeatherLoadingState();

    try {
      http.Response response = await _weatherAPI.getGlobalWeather(aLatitude, aLongitude);
      if (response != null && response.body.isNotEmpty) {
        // print('$runtimeType debug with weather response data : ${json.decode(response.body)}');
        WeatherJsonModel rawWeather = WeatherJsonModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
        http.Response currLocResponse = await _weatherAPI.getCurrentWeatherLocation(aLatitude, aLongitude);

        if (currLocResponse != null && currLocResponse.body.isNotEmpty) {
          // print('$runtimeType debug with current location weather data : ${json.decode(currLocResponse.body)}');

          CurrentWeatherJsonModel rawCurrentWeather = CurrentWeatherJsonModel.fromJson(
            json.decode(currLocResponse.body) as Map<String, dynamic>,
          );

          try {
            this.homeWeatherDataObj.translateFromRawWeatherResource(rawWeather, rawCurrentWeather);
            yield GlobalWeatherLoadFinishState();
          } catch (error) {
            yield GlobalWeatherErrorState(error.toString());
          }
        } else
          yield GlobalWeatherResponseFailState(); // invalid response body
      } else
        yield GlobalWeatherResponseFailState(); // invalid response body
    } catch (error) {
      yield GlobalWeatherErrorState(error.toString());
    }
  }
}
