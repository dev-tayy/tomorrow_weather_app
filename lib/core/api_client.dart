import 'package:dio/dio.dart';
import 'package:tomorrow_weather/model/weather.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://api.tomorrow.io/v4",
  ));

  //replace with your ApiKEY
  //get your key from app.tomorrow.io/development/keys
  static const String apiKey = 'tpk3Eyyloes5xWTnlcW7uKiDBUO4OL3A';

  //pick a location to get the weather
  static const location = [40.758, -73.9855]; //New york 

  //// list the fields you want to get from the api
  static const fields = [
    "windSpeed",
    "windDirection",
    "temperature",
    "temperatureApparent",
    "weatherCode",
    "humidity",
    "visibility",
    "dewPoint",
    "cloudCover",
    "precipitationType"
  ];

  // choose the unit system, either metric or imperial
  static const units = "imperial";

  // set the timesteps, like "current", "1h" and "1d"
  static const timesteps = ["current", "1d"];

  // configure the time frame up to 6 hours back and 15 days out
  String startTime =
      DateTime.now().toUtc().add(const Duration(minutes: 0)).toIso8601String();
  String endTime =
      DateTime.now().toUtc().add(const Duration(days: 4)).toIso8601String();

  //method to get the weather data
  Future<Weather> getWeather() async {
    try {
      final response = await _dio.get('/timelines', queryParameters: {
        'location': location.join(','),
        'apikey': apiKey,
        'fields': fields,
        'units': units,
        'timesteps': timesteps,
        'startTime': startTime,
        'endTime': endTime
      });

      return Weather.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response!.data);
      return e.response!.data;
    }
  }

  static String handleWeatherCode(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return "Unknown";
      case 1000:
        return 'Clear, Sunny';
      case 1100:
        return 'Mostly Clear';
      case 1101:
        return 'Partly Cloudy';
      case 1102:
        return 'Mostly Cloudy';
      case 1001:
        return 'Cloudy';
      case 2000:
        return 'Fog';
      case 4200:
        return 'Light Rain';
      case 6200:
        return 'Light Freezing Rain';
      default:
        return 'Unknown';
    }
  }

  static String handleWeatherIcon(String weatherCodeName) {
    switch (weatherCodeName) {
      case 'Clear, Sunny':
        return "assets/images/clear.png";
      case 'Mostly Clear':
        return 'assets/images/mostly_clear.png';
      case 'Partly Cloudy':
        return 'assets/images/partly_cloudy.png';
      case 'Mostly Cloudy':
        return 'assets/images/mostly_cloudy.png';
      case 'Cloudy':
        return 'assets/images/cloudy.png';
      case 'Fog':
        return 'assets/images/fog.png';
      case 'Light Rain':
        return 'assets/images/light_rain.png';
      case 'Light Freezing Rain':
        return 'assets/images/light_freezing_rain.png';
      default:
        return '';
    }
  }
}

      // "0": "Unknown",
      // "1000": "Clear, Sunny",
      // "1100": "Mostly Clear",
      // "1101": "Partly Cloudy",
      // "1102": "Mostly Cloudy",
      // "1001": "Cloudy",
      // "2000": "Fog",
      // "2100": "Light Fog",
      // "4000": "Drizzle",
      // "4001": "Rain",
      // "4200": "Light Rain",
      // "4201": "Heavy Rain",
      // "5000": "Snow",
      // "5001": "Flurries",
      // "5100": "Light Snow",
      // "5101": "Heavy Snow",
      // "6000": "Freezing Drizzle",
      // "6001": "Freezing Rain",
      // "6200": "Light Freezing Rain",
      // "6201": "Heavy Freezing Rain",
      // "7000": "Ice Pellets",
      // "7101": "Heavy Ice Pellets",
      // "7102": "Light Ice Pellets",
      // "8000": "Thunderstorm"