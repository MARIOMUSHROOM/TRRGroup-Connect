part of 'global_weather_bloc.dart';

@immutable
abstract class GlobalWeatherEvent {}

class GlobalWeatherRetrieveDataEvent extends GlobalWeatherEvent {
  final double latitude;
  final double longitude;
  GlobalWeatherRetrieveDataEvent(this.latitude, this.longitude);
}
