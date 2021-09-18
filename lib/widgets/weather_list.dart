import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/api-service.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/provider/list_provider.dart';

class WeatherList extends ConsumerWidget {
  const WeatherList({
    Key? key,
    required this.context,
  }) : super(key: key);

  final context;

  String getIcon(String icon) => Uri(
        scheme: "https",
        host: "openweathermap.org",
        pathSegments: {"img", "wn", "$icon@2x.png"},
      ).toString();

  showDurationOfTestimony(String dateTime) {
    final DateFormat formatter = DateFormat.yMMMd('en_US');
    DateTime postDateTime = DateTime.parse(dateTime).toLocal();
    DateTime currDateTime = DateTime.now().toLocal();
    Duration differenceInPostAndCurr = currDateTime.difference(postDateTime);

    return formatter.format(DateTime.parse(dateTime).toLocal());
  }

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(getWeatherData);
    return Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 200,
          child: Consumer(builder: (context, watch, _) {
          
            if (viewModel.weatherReport.length == 0) {
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 80),
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.yellow));
            }
            if (viewModel.weatherReport.length == 0) {
              return Text("Error has occured");
            } else {
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                        shrinkWrap: true,
                        clipBehavior: Clip.hardEdge,
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.weatherReport.length,
                        // model.weatherReport.length,
                        itemBuilder: (context, index) {
                          WeatherModel weatherBox =
                              viewModel.weatherReport[index]!;
                          // model.weatherReport[index]!;

                          return GestureDetector(
                            onTap: () {
                              watch(getUpdatedData).updateWeather(
                                weatherBox.name!,
                                weatherBox.weather![0].main!,
                                (weatherBox.main!.temp!),
                                weatherBox.dt.toString(),
                                DateTime.now().toString(),
                                weatherBox.weather![0].icon!,
                              );
                            },
                            child: Container(
                              width: 110,
                              // height: 200,
                              padding: EdgeInsets.only(
                                  top: 25, bottom: 10, left: 7, right: 7),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).backgroundColor,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    // weatherReport.name!
                                    weatherBox.name!,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    weatherBox.weather![0].main!,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ((weatherBox.main!.temp! * 9 / 5 - 459.67)
                                                .toString())
                                            .substring(0, 4) +
                                        " °F",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Image.network(
                                    getIcon(weatherBox.weather![0].icon!),
                                    height: 33,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    showDurationOfTestimony(
                                        DateTime.now().toString()),
                                    // weatherReport.dt.toString(),
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Text(
                                    // DateTime.now().toString(),
                                    DateTime.now().toString().substring(10, 16),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
              );
            }
          }),
        ));
  }
}
