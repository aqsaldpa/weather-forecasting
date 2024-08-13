import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_apps/models/weather.dart';
import 'package:weather_apps/models/wilayah.dart';
import 'package:xml/xml.dart';

class WeatherRepository {
  // Fetch list of Wilayah (Regions)
  Future<List<Wilayah>> fetchWilayah() async {
    final response = await http.get(
        Uri.parse('https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((json) => Wilayah.fromMap(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load wilayah data');
    }
  }

  Future<List<Weather>> fetchWeatherByWilayah(String province) async {
    final response = await http.get(Uri.parse(
        'https://data.bmkg.go.id/DataMKG/MEWS/DigitalForecast/DigitalForecast-$province.xml'));

    if (response.statusCode == 200) {
      final document = XmlDocument.parse(response.body);
      final areas = document.findAllElements('area');

      return areas.map((area) => Weather.fromXml(area)).toList();
    } else {
      throw Exception('Failed to load weather data for wilayah $province');
    }
  }
}
