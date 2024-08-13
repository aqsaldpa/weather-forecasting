import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_apps/models/weather.dart';
import 'package:weather_apps/models/wilayah.dart';
import 'package:weather_apps/repositories/weather_repository.dart';

final wilayahProvider = FutureProvider<List<Wilayah>>((ref) async {
  final repository = WeatherRepository();
  return repository.fetchWilayah();
});

final weatherProvider =
    FutureProvider.family<List<Weather>, String>((ref, province) async {
  final repository = WeatherRepository();
  return repository.fetchWeatherByWilayah(province);
});
