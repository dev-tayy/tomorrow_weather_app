
import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    required this.data,
    required this.warnings,
  });

  Data data;
  List<Warning> warnings;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        data: Data.fromJson(json["data"]),
        warnings: List<Warning>.from(
            json["warnings"].map((x) => Warning.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "warnings": List<dynamic>.from(warnings.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.timelines,
  });

  List<Timeline> timelines;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        timelines: List<Timeline>.from(
            json["timelines"].map((x) => Timeline.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timelines": List<dynamic>.from(timelines.map((x) => x.toJson())),
      };
}

class Timeline {
  Timeline({
    required this.timestep,
    required this.startTime,
    required this.endTime,
    required this.intervals,
  });

  String timestep;
  DateTime startTime;
  DateTime endTime;
  List<Interval> intervals;

  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
        timestep: json["timestep"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        intervals: List<Interval>.from(
            json["intervals"].map((x) => Interval.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timestep": timestep,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "intervals": List<dynamic>.from(intervals.map((x) => x.toJson())),
      };
}

class Interval {
  Interval({
    required this.startTime,
    required this.values,
  });

  DateTime startTime;
  Values values;

  factory Interval.fromJson(Map<String, dynamic> json) => Interval(
        startTime: DateTime.parse(json["startTime"]),
        values: Values.fromJson(json["values"]),
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime.toIso8601String(),
        "values": values.toJson(),
      };
}

class Values {
  Values({
    required this.windSpeed,
    required this.windDirection,
    required this.temperature,
    required this.temperatureApparent,
    required this.weatherCode,
    required this.humidity,
    required this.visibility,
    required this.dewPoint,
    required this.precipitationType,
    required this.cloudCover,
  });

  double windSpeed;
  double windDirection;
  double temperature;
  double temperatureApparent;
  int weatherCode;
  double humidity;
  double visibility;
  double dewPoint;
  int precipitationType;
  double cloudCover;

  factory Values.fromJson(Map<String, dynamic> json) => Values(
        windSpeed: json["windSpeed"].toDouble(),
        windDirection: json["windDirection"].toDouble(),
        temperature: json["temperature"].toDouble(),
        temperatureApparent: json["temperatureApparent"].toDouble(),
        weatherCode: json["weatherCode"],
        humidity: json["humidity"].toDouble(),
        visibility: json["visibility"].toDouble(),
        dewPoint: json["dewPoint"].toDouble(),
        precipitationType: json["precipitationType"],
        cloudCover: json["cloudCover"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "windSpeed": windSpeed,
        "windDirection": windDirection,
        "temperature": temperature,
        "temperatureApparent": temperatureApparent,
        "weatherCode": weatherCode,
        "humidity": humidity,
        "visibility": visibility,
        "dewPoint": dewPoint,
        "precipitationType": precipitationType,
        "cloudCover": cloudCover,
      };
}

class Warning {
  Warning({
    required this.code,
    required this.type,
    required this.message,
  });

  int code;
  String type;
  String message;

  factory Warning.fromJson(Map<String, dynamic> json) => Warning(
        code: json["code"],
        type: json["type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "type": type,
        "message": message,
      };
}
