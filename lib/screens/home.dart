import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomorrow_weather/components/forecast_container.dart';
import 'package:tomorrow_weather/components/highlight_container.dart';
import 'package:tomorrow_weather/core/api_client.dart';
import 'package:tomorrow_weather/model/weather.dart';
import 'package:tomorrow_weather/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiClient _apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      body: SafeArea(
        child: FutureBuilder<Weather>(
            future: _apiClient.getWeather(),
            builder: (context, snapshot) {
              //loading state
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                //when the future is complete and there is error, display it.
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  //when the future is complete and has no error, show the weather
                  int weatherCode = snapshot
                      .data!.data.timelines[0].intervals[0].values.weatherCode;
                  //weatherName
                  String weatherCodeName =
                      ApiClient.handleWeatherCode(weatherCode);
                  //weatherIcon
                  String weatherCodeIcon =
                      ApiClient.handleWeatherIcon(weatherCodeName);
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: Container(
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage(
                                  'assets/images/Cloud-background.png'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                AppColors.backgroundColor.withOpacity(0.03),
                                BlendMode.dstIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 15.0,
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const Text('Current Weather',
                                style: TextStyle(
                                  color: AppColors.greyShade1,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w700,
                                )),
                            const SizedBox(height: 30.0),
                            Image.asset(
                              weatherCodeIcon,
                              width: 150,
                              height: 150,
                            ),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  text: snapshot.data!.data.timelines[0]
                                      .intervals[0].values.temperature
                                      .toStringAsFixed(0)
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 144,
                                      color: AppColors.greyShade1,
                                      fontWeight: FontWeight.w500),
                                  children: const [
                                    TextSpan(
                                      text: '°F',
                                      style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 48,
                                        color: AppColors.textBlueColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Text(weatherCodeName,
                                  style: const TextStyle(
                                      fontSize: 42,
                                      color: AppColors.textBlueColor,
                                      fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Today',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.textdarkBlueColor,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(width: 16),
                                const Text(
                                  '·',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.textdarkBlueColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                    DateFormat(
                                            DateFormat.ABBR_MONTH_WEEKDAY_DAY)
                                        .format(DateTime.now())
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: AppColors.textdarkBlueColor,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            const SizedBox(height: 33),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.location_on,
                                    color: AppColors.textdarkBlueColor),
                                SizedBox(width: 9),
                                Text('New York',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.textdarkBlueColor,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Forecast',
                                    style: TextStyle(
                                      color: AppColors.greyShade1,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w700,
                                    )),
                                const SizedBox(height: 30.0),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ForecastContainer(
                                        timeline:
                                            snapshot.data!.data.timelines,
                                        index: 2,
                                      ),
                                      const SizedBox(width: 20),
                                      ForecastContainer(
                                        timeline:
                                            snapshot.data!.data.timelines,
                                        index: 3,
                                      ),
                                      const SizedBox(width: 20),
                                      ForecastContainer(
                                        timeline:
                                            snapshot.data!.data.timelines,
                                        index: 4,
                                      ),
                                      const SizedBox(width: 20),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 50.0),
                                const Text("Today's Highlights",
                                    style: TextStyle(
                                      color: AppColors.greyShade1,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w700,
                                    )),
                                const SizedBox(height: 30.0),
                                HighlightContainer(
                                    label: 'Wind Speed',
                                    value: snapshot.data!.data.timelines[0]
                                        .intervals[0].values.windSpeed
                                        .toStringAsFixed(0)
                                        .toString(),
                                    unit: ' mph'),
                                const SizedBox(height: 20),
                                HighlightContainer(
                                    label: 'Humidity',
                                    value: snapshot.data!.data.timelines[0]
                                        .intervals[0].values.humidity
                                        .toStringAsFixed(0)
                                        .toString(),
                                    unit: ' %'),
                                const SizedBox(height: 20),
                                HighlightContainer(
                                    label: 'Visibility',
                                    value: snapshot.data!.data.timelines[0]
                                        .intervals[0].values.visibility
                                        .toStringAsFixed(0)
                                        .toString(),
                                    unit: ' miles'),
                                const SizedBox(height: 20),
                                HighlightContainer(
                                    label: 'Cloud Cover',
                                    value: snapshot.data!.data.timelines[0]
                                        .intervals[0].values.cloudCover
                                        .toStringAsFixed(0)
                                        .toString(),
                                    unit: ' %'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }
            }),
      ),
    );
  }
}
