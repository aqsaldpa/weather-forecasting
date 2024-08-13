import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_apps/models/wilayah.dart';
import 'package:weather_apps/viewmodels/weather_vm.dart';
import 'package:weather_apps/common/string_ext.dart';

class WeatherHeader extends StatelessWidget {
  final Wilayah? selectedCity;

  const WeatherHeader({
    super.key,
    required this.selectedCity,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedCity == null) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.blue.shade600],
          ),
        ),
        child: const Center(
          child: Text(
            'Pilih Provinsi dan Kota',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      );
    }

    return Consumer(
      builder: (context, ref, child) {
        final weatherAsyncValue =
            ref.watch(weatherProvider(selectedCity!.propinsi));
        return weatherAsyncValue.when(
          data: (weatherList) {
            final cityWeather = weatherList.firstWhere(
              (weather) => weather.areaId == selectedCity!.id,
              orElse: () => weatherList.first,
            );
            final tempForecast = cityWeather.forecasts.firstWhere(
              (f) => f.id == 't',
              orElse: () => cityWeather.forecasts.first,
            );
            final weatherForecast = cityWeather.forecasts.firstWhere(
              (f) => f.id == 'weather',
              orElse: () => cityWeather.forecasts.first,
            );

            final currentHour = DateTime.now().hour;

            final currentTempTimeRange = tempForecast.timeRanges.lastWhere(
              (tr) => int.parse(tr.h) <= currentHour,
              orElse: () => tempForecast.timeRanges.first,
            );
            final currentTemp = currentTempTimeRange.value
                .firstWhere((v) => v.unit == 'C',
                    orElse: () => currentTempTimeRange.value.first)
                .text;

            final currentWeatherTimeRange =
                weatherForecast.timeRanges.lastWhere(
              (tr) => int.parse(tr.h) <= currentHour,
              orElse: () => weatherForecast.timeRanges.first,
            );
            final currentWeatherCode = currentWeatherTimeRange.value.first.text;

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade300, Colors.blue.shade600],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedCity!.propinsi,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  Text(
                    selectedCity!.kota,
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$currentTemp°',
                    style: const TextStyle(fontSize: 80, color: Colors.white),
                  ),
                  Text(
                    DateFormat('EEEE, d MMMM HH:mm').format(DateTime.now()),
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  Text(
                    getWeatherDesc(currentWeatherCode),
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Icon(
                    getWeatherIcon(currentWeatherCode),
                    size: 90,
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        );
      },
    );
  }
}
