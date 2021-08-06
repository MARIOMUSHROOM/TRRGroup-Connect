// To parse this JSON data, do
//
//     final weatherJsonModel = weatherJsonModelFromJson(jsonString);

import 'dart:convert';

WeatherJsonModel weatherJsonModelFromJson(String str) => WeatherJsonModel.fromJson(json.decode(str));

String weatherJsonModelToJson(WeatherJsonModel data) => json.encode(data.toJson());

class WeatherJsonModel {
  WeatherJsonModel({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.minutely,
    this.hourly,
    this.daily,
  });

  num lat;
  num lon;
  String timezone;
  int timezoneOffset;
  Current current;
  List<Minutely> minutely;
  List<Current> hourly;
  List<Daily> daily;

  bool get isWeatherExist => (lat != null && lon != null);

  factory WeatherJsonModel.fromJson(Map<String, dynamic> json) => WeatherJsonModel(
        lat: json["lat"] == null ? null : json["lat"], //.toDouble(),
        lon: json["lon"] == null ? null : json["lon"], //.toDouble(),
        timezone: json["timezone"] == null ? '' : json["timezone"],
        timezoneOffset: json["timezone_offset"] == null ? 0 : json["timezone_offset"],
        current: json["current"] == null ? null : Current.fromJson(json["current"]),
        minutely: json["minutely"] == null ? null : List<Minutely>.from(json["minutely"].map((x) => Minutely.fromJson(x))),
        hourly: json["hourly"] == null ? null : List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
        daily: json["daily"] == null ? null : List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "timezone": timezone == null ? null : timezone,
        "timezone_offset": timezoneOffset == null ? null : timezoneOffset,
        "current": current == null ? null : current.toJson(),
        "minutely": minutely == null ? null : List<dynamic>.from(minutely.map((x) => x.toJson())),
        "hourly": hourly == null ? null : List<dynamic>.from(hourly.map((x) => x.toJson())),
        "daily": daily == null ? null : List<dynamic>.from(daily.map((x) => x.toJson())),
      };
}

class Current {
  Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.weather,
    this.windGust,
    this.pop,
    this.rain,
  });

  int dt;
  int sunrise;
  int sunset;
  num temp;
  num feelsLike;
  int pressure;
  int humidity;
  num dewPoint;
  num uvi;
  int clouds;
  int visibility;
  num windSpeed;
  int windDeg;
  List<Weather> weather;
  num windGust;
  num pop;
  Rain rain;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"] == null ? null : json["dt"],
        sunrise: json["sunrise"] == null ? null : json["sunrise"],
        sunset: json["sunset"] == null ? null : json["sunset"],
        temp: json["temp"] == null ? null : json["temp"], //.toDouble(),
        feelsLike: json["feels_like"] == null ? null : json["feels_like"], //.toDouble(),
        pressure: json["pressure"] == null ? null : json["pressure"],
        humidity: json["humidity"] == null ? null : json["humidity"],
        dewPoint: json["dew_point"] == null ? null : json["dew_point"], //.toDouble(),
        uvi: json["uvi"] == null ? null : json["uvi"], // .toDouble(),
        clouds: json["clouds"] == null ? null : json["clouds"],
        visibility: json["visibility"] == null ? null : json["visibility"],
        windSpeed: json["wind_speed"] == null ? null : json["wind_speed"], //.toDouble(),
        windDeg: json["wind_deg"] == null ? null : json["wind_deg"],
        weather: json["weather"] == null ? null : List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        windGust: json["wind_gust"] == null ? null : json["wind_gust"], //.toDouble(),
        pop: json["pop"] == null ? null : json["pop"], //.toDouble(),
        rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt == null ? null : dt,
        "sunrise": sunrise == null ? null : sunrise,
        "sunset": sunset == null ? null : sunset,
        "temp": temp == null ? null : temp,
        "feels_like": feelsLike == null ? null : feelsLike,
        "pressure": pressure == null ? null : pressure,
        "humidity": humidity == null ? null : humidity,
        "dew_point": dewPoint == null ? null : dewPoint,
        "uvi": uvi == null ? null : uvi,
        "clouds": clouds == null ? null : clouds,
        "visibility": visibility == null ? null : visibility,
        "wind_speed": windSpeed == null ? null : windSpeed,
        "wind_deg": windDeg == null ? null : windDeg,
        "weather": weather == null ? null : List<dynamic>.from(weather.map((x) => x.toJson())),
        "wind_gust": windGust == null ? null : windGust,
        "pop": pop == null ? null : pop,
        "rain": rain == null ? null : rain.toJson(),
      };
}

class Rain {
  Rain({
    this.the1H,
  });

  num the1H;

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the1H: json["1h"] == null ? null : json["1h"], //.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "1h": the1H == null ? null : the1H,
      };
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"] == null ? null : json["id"],
        main: json["main"] == null ? null : json["main"], //mainValues.map[json["main"]],
        description: json["description"] == null ? null : json["description"], //descriptionValues.map[json["description"]],
        icon: json["icon"] == null ? null : json["icon"], //iconValues.map[json["icon"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "main": main == null ? null : main, //mainValues.reverse[main],
        "description": description == null ? null : description, //descriptionValues.reverse[description],
        "icon": icon == null ? null : icon, //iconValues.reverse[icon],
      };
}

// enum Description { FEW_CLOUDS, LIGHT_RAIN, OVERCAST_CLOUDS, SCATTERED_CLOUDS, BROKEN_CLOUDS }

// final descriptionValues = EnumValues({
//   "broken clouds": Description.BROKEN_CLOUDS,
//   "few clouds": Description.FEW_CLOUDS,
//   "light rain": Description.LIGHT_RAIN,
//   "overcast clouds": Description.OVERCAST_CLOUDS,
//   "scattered clouds": Description.SCATTERED_CLOUDS
// });

// enum Icon { THE_02_D, THE_10_D, THE_04_D, THE_03_D, THE_04_N, THE_10_N }

// final iconValues =
//     EnumValues({"02d": Icon.THE_02_D, "03d": Icon.THE_03_D, "04d": Icon.THE_04_D, "04n": Icon.THE_04_N, "10d": Icon.THE_10_D, "10n": Icon.THE_10_N});

// enum Main { CLOUDS, RAIN }

// final mainValues = EnumValues({"Clouds": Main.CLOUDS, "Rain": Main.RAIN});

class Daily {
  Daily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.clouds,
    this.pop,
    this.rain,
    this.uvi,
  });

  int dt;
  int sunrise;
  int sunset;
  int moonrise;
  int moonset;
  num moonPhase;
  Temp temp;
  FeelsLike feelsLike;
  int pressure;
  int humidity;
  num dewPoint;
  num windSpeed;
  int windDeg;
  num windGust;
  List<Weather> weather;
  int clouds;
  num pop;
  num rain;
  num uvi;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"] == null ? null : json["dt"],
        sunrise: json["sunrise"] == null ? null : json["sunrise"],
        sunset: json["sunset"] == null ? null : json["sunset"],
        moonrise: json["moonrise"] == null ? null : json["moonrise"],
        moonset: json["moonset"] == null ? null : json["moonset"],
        moonPhase: json["moon_phase"] == null ? null : json["moon_phase"], //.toDouble(),
        temp: json["temp"] == null ? null : Temp.fromJson(json["temp"]),
        feelsLike: json["feels_like"] == null ? null : FeelsLike.fromJson(json["feels_like"]),
        pressure: json["pressure"] == null ? null : json["pressure"],
        humidity: json["humidity"] == null ? null : json["humidity"],
        dewPoint: json["dew_point"] == null ? null : json["dew_point"], //.toDouble(),
        windSpeed: json["wind_speed"] == null ? null : json["wind_speed"], //.toDouble(),
        windDeg: json["wind_deg"] == null ? null : json["wind_deg"],
        windGust: json["wind_gust"] == null ? null : json["wind_gust"], //.toDouble(),
        weather: json["weather"] == null ? null : List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: json["clouds"] == null ? null : json["clouds"],
        pop: json["pop"] == null ? null : json["pop"], //.toDouble(),
        rain: json["rain"] == null ? null : json["rain"], //.toDouble(),
        uvi: json["uvi"] == null ? null : json["uvi"], //.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt == null ? null : dt,
        "sunrise": sunrise == null ? null : sunrise,
        "sunset": sunset == null ? null : sunset,
        "moonrise": moonrise == null ? null : moonrise,
        "moonset": moonset == null ? null : moonset,
        "moon_phase": moonPhase == null ? null : moonPhase,
        "temp": temp == null ? null : temp.toJson(),
        "feels_like": feelsLike == null ? null : feelsLike.toJson(),
        "pressure": pressure == null ? null : pressure,
        "humidity": humidity == null ? null : humidity,
        "dew_point": dewPoint == null ? null : dewPoint,
        "wind_speed": windSpeed == null ? null : windSpeed,
        "wind_deg": windDeg == null ? null : windDeg,
        "wind_gust": windGust == null ? null : windGust,
        "weather": weather == null ? null : List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds == null ? null : clouds,
        "pop": pop == null ? null : pop,
        "rain": rain == null ? null : rain,
        "uvi": uvi == null ? null : uvi,
      };
}

class FeelsLike {
  FeelsLike({
    this.day,
    this.night,
    this.eve,
    this.morn,
  });

  num day;
  num night;
  num eve;
  num morn;

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"] == null ? null : json["day"], //.toDouble(),
        night: json["night"] == null ? null : json["night"], //.toDouble(),
        eve: json["eve"] == null ? null : json["eve"], //.toDouble(),
        morn: json["morn"] == null ? null : json["morn"], //.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day == null ? null : day,
        "night": night == null ? null : night,
        "eve": eve == null ? null : eve,
        "morn": morn == null ? null : morn,
      };
}

class Temp {
  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  num day;
  num min;
  num max;
  num night;
  num eve;
  num morn;

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"] == null ? null : json["day"], //.toDouble(),
        min: json["min"] == null ? null : json["min"], //.toDouble(),
        max: json["max"] == null ? null : json["max"], //.toDouble(),
        night: json["night"] == null ? null : json["night"], //.toDouble(),
        eve: json["eve"] == null ? null : json["eve"], //.toDouble(),
        morn: json["morn"] == null ? null : json["morn"], //.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day == null ? null : day,
        "min": min == null ? null : min,
        "max": max == null ? null : max,
        "night": night == null ? null : night,
        "eve": eve == null ? null : eve,
        "morn": morn == null ? null : morn,
      };
}

class Minutely {
  Minutely({
    this.dt,
    this.precipitation,
  });

  int dt;
  int precipitation;

  factory Minutely.fromJson(Map<String, dynamic> json) => Minutely(
        dt: json["dt"] == null ? null : json["dt"],
        precipitation: json["precipitation"] == null ? null : json["precipitation"],
      );

  Map<String, dynamic> toJson() => {
        "dt": dt == null ? null : dt,
        "precipitation": precipitation == null ? null : precipitation,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
