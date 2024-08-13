import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_apps/common/string_ext.dart';
import 'package:weather_apps/models/wilayah.dart';
import 'package:weather_apps/viewmodels/weather_vm.dart';

class ForecastTabs extends StatelessWidget {
  final bool showToday;
  final bool isLoading;
  final ValueChanged<bool> onTabSelected;
  final Wilayah selectedCity;

  const ForecastTabs({
    super.key,
    required this.showToday,
    required this.isLoading,
    required this.onTabSelected,
    required this.selectedCity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTabButton('Hari ini', showToday),
            _buildTabButton('Besok', !showToday),
          ],
        ),
        isLoading ? const CircularProgressIndicator() : _buildHourlyForecast(),
      ],
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return InkWell(
      onTap: () => onTabSelected(text == 'Hari ini'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildHourlyForecast() {
    return Consumer(
      builder: (context, ref, child) {
        final weatherAsyncValue =
            ref.watch(weatherProvider(selectedCity.propinsi));
        return weatherAsyncValue.when(
          data: (weatherList) {
            final cityWeather = weatherList.firstWhere(
              (weather) => weather.areaId == selectedCity.id,
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

            final startHour = showToday ? 0 : 24;

            return SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 24,
                itemBuilder: (context, index) {
                  final hour = startHour + index;

                  String temp = 'N/A';
                  String weatherCode = 'N/A';

                  var tempTimeRange = tempForecast.timeRanges.lastWhere(
                    (tr) => int.parse(tr.h) <= hour,
                    orElse: () => tempForecast.timeRanges.first,
                  );
                  temp = tempTimeRange.value
                      .firstWhere((v) => v.unit == 'C',
                          orElse: () => tempTimeRange.value.first)
                      .text;

                  var weatherTimeRange = weatherForecast.timeRanges.lastWhere(
                    (tr) => int.parse(tr.h) <= hour,
                    orElse: () => weatherForecast.timeRanges.first,
                  );
                  weatherCode = weatherTimeRange.value.first.text;

                  return _buildHourlyForecastItem(
                    hour: hour % 24,
                    temp: temp,
                    weatherCode: weatherCode,
                  );
                },
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        );
      },
    );
  }

  Widget _buildHourlyForecastItem({
    required int hour,
    required String temp,
    required String weatherCode,
  }) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${hour.toString().padLeft(2, '0')}:00'),
          const SizedBox(height: 6),
          Icon(getWeatherIcon(weatherCode), size: 20),
          const SizedBox(height: 6),
          Text('$temp°'),
        ],
      ),
    );
  }
}
