import 'package:xml/xml.dart';

class Weather {
  final String areaId;
  final String areaName;
  final List<Forecast> forecasts;

  Weather({
    required this.areaId,
    required this.areaName,
    required this.forecasts,
  });

  factory Weather.fromXml(XmlElement area) {
    return Weather(
      areaId: area.getAttribute('id') ?? '',
      areaName: area.getAttribute('description') ?? '',
      forecasts: area.findElements('parameter').map((param) {
        return Forecast.fromXml(param);
      }).toList(),
    );
  }

  @override
  String toString() {
    return 'Weather(areaId: $areaId, areaName: $areaName, forecasts: $forecasts)';
  }
}

class Forecast {
  final String id;
  final String description;
  final String type;
  final List<TimeRange> timeRanges;

  Forecast({
    required this.id,
    required this.description,
    required this.type,
    required this.timeRanges,
  });

  factory Forecast.fromXml(XmlElement param) {
    return Forecast(
      id: param.getAttribute('id') ?? '',
      description: param.getAttribute('description') ?? '',
      type: param.getAttribute('type') ?? '',
      timeRanges: param.findElements('timerange').map((timerange) {
        return TimeRange.fromXml(timerange);
      }).toList(),
    );
  }

  @override
  String toString() {
    return 'Forecast(id: $id, description: $description, type: $type, timeRanges: $timeRanges)';
  }
}

class TimeRange {
  final String type;
  final String h;
  final String datetime;
  final List<Value> value;

  TimeRange({
    required this.type,
    required this.h,
    required this.datetime,
    required this.value,
  });

  factory TimeRange.fromXml(XmlElement timerange) {
    return TimeRange(
      type: timerange.getAttribute('type') ?? '',
      h: timerange.getAttribute('h') ?? '',
      datetime: timerange.getAttribute('datetime') ?? '',
      value: timerange.findElements('value').map((value) {
        return Value.fromXml(value);
      }).toList(),
    );
  }

  @override
  String toString() {
    return 'TimeRange(type: $type, h: $h, datetime: $datetime, value: $value)';
  }
}

class Value {
  final String unit;
  final String text;

  Value({required this.unit, required this.text});

  factory Value.fromXml(XmlElement value) {
    return Value(
      unit: value.getAttribute('unit') ?? '',
      text: value.text,
    );
  }

  @override
  String toString() {
    return 'Value(unit: $unit,text: $text)';
  }
}
