import 'package:http/http.dart' as http;
import 'package:weather_demo/secrets.dart';

class WeatherProvider {
// fetching data from external weather api
  Future<String> getCurrentWeather({required String cityName}) async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey',
        ),
      );

      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
