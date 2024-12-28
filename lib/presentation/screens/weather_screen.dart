import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:weather_demo/bloc/weather_bloc.dart';
import 'package:weather_demo/presentation/widgets/additional_info_item.dart';
import 'package:weather_demo/presentation/widgets/hourly_forecast_item.dart';
import 'package:weather_demo/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(
          WeatherFetched(cityName: 'London'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<WeatherBloc>().add(
                    WeatherFetched(cityName: 'London'),
                  );
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherFailure) {
            return Center(
              child: Text(state.errorMsg),
            );
          }
          if (state is! WeatherSuccess) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          final currentWeatherData = state.weatherModel;

          final currentTemp = currentWeatherData.currentTemp;
          final currentSky = currentWeatherData.currentSky;
          final currentPressure = currentWeatherData.currentPressure;
          final currentWindSpeed = currentWeatherData.currentWindSpeed;
          final currentHumidity = currentWeatherData.currentHumidity;
          // final hourlyForecast = currentWeatherData[1];
          // final hourlySky = currentWeatherData[1]['weather'][0]['main'];
          // final hourlyTemp = hourlyForecast['main']['temp'].toString();
          // final time = DateTime.parse(hourlyForecast['dt_txt']);

          // debugPrint(" hour first - $hourlyForecast $hourlySky $hourlyTemp $time");
          // final hourlyForecast1 = currentWeatherData[2];
          // final hourlySky1 = currentWeatherData[2]['weather'][0]['main'];
          // final hourlyTemp1 = hourlyForecast1['main']['temp'].toString();
          // final time1 = DateTime.parse(hourlyForecast1['dt_txt']);

          // debugPrint(" hour sec - $hourlyForecast1 $hourlySky1 $hourlyTemp1 $time1");

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp K',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                currentSky,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Hourly Forecast',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      // final hourlyForecast = data['list'][index + 1];
                      // final hourlySky =
                      //     data['list'][index + 1]['weather'][0]['main'];
                      // final hourlyTemp =
                      //     hourlyForecast['main']['temp'].toString();
                      // final time = DateTime.parse(hourlyForecast['dt_txt']);

                      final hourlySky =
                          state.weatherModel.weathHourList[index].hourlySky;
                      final hourlyTemp =
                          state.weatherModel.weathHourList[index].hourlyTemp;
                      final time = state.weatherModel.weathHourList[index].time;

                      return HourlyForecastItem(
                        // time: DateFormat.j().format(time),
                        time: time,
                        temperature: hourlyTemp,
                        icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                            ? Icons.cloud
                            : Icons.sunny,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: currentHumidity.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
