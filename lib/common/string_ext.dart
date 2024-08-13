import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

IconData getWeatherIcon(String weatherCode) {
  int code = int.tryParse(weatherCode) ?? 0;
  if (code == 0) return WeatherIcons.day_sunny;
  if (code <= 2) return WeatherIcons.day_cloudy;
  if (code <= 4) return WeatherIcons.cloud;
  if (code <= 10) return WeatherIcons.day_haze;
  if (code <= 60) return WeatherIcons.fog;
  if (code <= 63) return WeatherIcons.day_rain;
  if (code <= 97) return WeatherIcons.day_thunderstorm;
  return WeatherIcons.na;
}

String getWeatherDesc(String weatherCode) {
  int code = int.tryParse(weatherCode) ?? 0;

  switch (code) {
    case 0:
      return "Cerah";
    case 1:
    case 2:
      return "Cerah Berawan";
    case 3:
      return "Berawan";
    case 4:
      return "Berawan Tebal";
    case 5:
      return "Udara Kabur";
    case 10:
      return "Asap";
    case 45:
    case 46:
      return "Kabut";
    case 60:
      return "Hujan Ringan";
    case 61:
      return "Hujan Sedang";
    case 63:
      return "Hujan Lebat";
    case 95:
      return "Hujan Petir";
    case 97:
      return "Hujan Petir Intensitas Tinggi";
    default:
      return "Tidak Diketahui";
  }
}
