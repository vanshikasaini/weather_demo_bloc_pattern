import 'dart:convert';

import 'package:weather_demo/data/data_provider/weather_data_provider.dart';
import 'package:weather_demo/models/weather_model.dart';
import 'package:weather_demo/models/weather_model_list.dart';

class WeatherRepository {
  final WeatherProvider weatherProvider;

  WeatherRepository(this.weatherProvider);
  // Future<WeatherModel> getCurrentWeather({required String cityName}) async {
  Future<WeatherModelList> getCurrentWeather({required String cityName}) async {
    try {
      //   String cityName = 'London';
      final weatherData =
          await weatherProvider.getCurrentWeather(cityName: cityName);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      // return WeatherModel.fromMap(data);
      // //OR
      // //return WeatherModel.fromJson(weatherData);
      return WeatherModelList.fromMap(data);
      //OR
      //return WeatherModelList.fromJson(weatherData);
    } catch (e) {
      throw e.toString();
    }
  }
}
