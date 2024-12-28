// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WeatherHourList {
  final String hourlyForecast;
  final String hourlyTemp;
  final String hourlySky;
  final String time;
  WeatherHourList({
    required this.hourlyForecast,
    required this.hourlyTemp,
    required this.hourlySky,
    required this.time,
  });

  WeatherHourList copyWith({
    String? hourlyForecast,
    String? hourlyTemp,
    String? hourlySky,
    String? time,
  }) {
    return WeatherHourList(
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
      hourlyTemp: hourlyTemp ?? this.hourlyTemp,
      hourlySky: hourlySky ?? this.hourlySky,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hourlyForecast': hourlyForecast,
      'hourlyTemp': hourlyTemp,
      'hourlySky': hourlySky,
      'time': time,
    };
  }

  factory WeatherHourList.fromMap(Map<String, dynamic> map) {
    return WeatherHourList(
      hourlyForecast: '',
      hourlyTemp: map['main']['temp'].toString(),
      hourlySky: map['weather'][0]['main'],
      time: DateTime.parse(map['dt_txt']).toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherHourList.fromJson(String source) =>
      WeatherHourList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherHourList(hourlyForecast: $hourlyForecast, hourlyTemp: $hourlyTemp, hourlySky: $hourlySky, time: $time)';
  }

  @override
  bool operator ==(covariant WeatherHourList other) {
    if (identical(this, other)) return true;

    return other.hourlyForecast == hourlyForecast &&
        other.hourlyTemp == hourlyTemp &&
        other.hourlySky == hourlySky &&
        other.time == time;
  }

  @override
  int get hashCode {
    return hourlyForecast.hashCode ^
        hourlyTemp.hashCode ^
        hourlySky.hashCode ^
        time.hashCode;
  }
}

class WeatherModelList {
  final double currentTemp;
  final String currentSky;
  final double currentPressure;
  final double currentWindSpeed;
  final double currentHumidity;
  final List<WeatherHourList> weathHourList;
  WeatherModelList({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.weathHourList,
  });

  WeatherModelList copyWith({
    double? currentTemp,
    String? currentSky,
    double? currentPressure,
    double? currentWindSpeed,
    double? currentHumidity,
    List<WeatherHourList>? weathHourList,
  }) {
    return WeatherModelList(
      currentTemp: currentTemp ?? this.currentTemp,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
      currentHumidity: currentHumidity ?? this.currentHumidity,
      weathHourList: weathHourList ?? this.weathHourList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
      'weathHourList': weathHourList.map((x) => x.toMap()).toList(),
    };
  }

  factory WeatherModelList.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];

    List<WeatherHourList> tt = [];
    List<dynamic> ttDynamic = [];

    // (map['weathHourList'] as List<dynamic>)
    //     .map((item) => WeatherHourList.fromMap(item))
    //     .toList();

    for (int i = 1; i <= 6; i++) {
      ttDynamic.add(map['list'][i]);

      // tt.add(map['list'][1].from(
      //   //tt.add(map['list'][i].from(
      //   //(map['weathHourList'] as List<int>).map<WeatherHourList>(
      //   (map['list'][1]).map<WeatherHourList>(
      //     (x) => WeatherHourList.fromMap(x as Map<String, dynamic>),
      //   ),
      // ));
    }
    debugPrint(" hour sec tt - ${tt.toString()}");
    return WeatherModelList(
      currentTemp: currentWeatherData['main']['temp'],
      currentSky: currentWeatherData['weather'][0]['main'],
      currentPressure: currentWeatherData['main']['pressure'],
      currentWindSpeed: currentWeatherData['wind']['speed'],
      currentHumidity: currentWeatherData['main']['humidity'],
      weathHourList:
          (ttDynamic).map((item) => WeatherHourList.fromMap(item)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModelList.fromJson(String source) =>
      WeatherModelList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModelList(currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currentWindSpeed: $currentWindSpeed, currentHumidity: $currentHumidity, weathHourList: $weathHourList)';
  }

  @override
  bool operator ==(covariant WeatherModelList other) {
    if (identical(this, other)) return true;

    return other.currentTemp == currentTemp &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currentWindSpeed == currentWindSpeed &&
        other.currentHumidity == currentHumidity &&
        listEquals(other.weathHourList, weathHourList);
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currentWindSpeed.hashCode ^
        currentHumidity.hashCode ^
        weathHourList.hashCode;
  }
}
