part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  //final WeatherModel weatherModel;

  final WeatherModelList weatherModel;
  WeatherSuccess({required this.weatherModel});
}

final class WeatherFailure extends WeatherState {
  final String errorMsg;

  WeatherFailure(this.errorMsg);
}

final class WeatherLoading extends WeatherState {}
