part of 'global_weather_bloc.dart';

@immutable
abstract class GlobalWeatherState {}

class GlobalWeatherInitial extends GlobalWeatherState {}

class GlobalWeatherLoadingState extends GlobalWeatherState {}

class GlobalWeatherLoadFinishState extends GlobalWeatherState {}

class GlobalWeatherResponseFailState extends GlobalWeatherState {}

// class GlobalWeatherTranslateToObjectFailState extends GlobalWeatherState {}

class GlobalWeatherErrorState extends GlobalWeatherState {
  final String errorMessage;
  GlobalWeatherErrorState(this.errorMessage);
  @override
  String toString() {
    return 'Global Weather State error with message : $errorMessage';
  }
}
