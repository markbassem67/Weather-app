import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/utils/conditions_severity_calculator.dart';
import '../../core/utils/hours_parcer.dart';
import '../../core/utils/weather_code_mapper.dart';
import '../../logic/cubit/weather_cubit.dart';
import '../../logic/cubit/weather_state.dart';
import '../widgets/custom_popupmenu.dart';
import '../widgets/days_forecast.dart';
import '../widgets/hourly_timeline.dart';
import '../widgets/location_services_disabled.dart';
import '../widgets/no_internetconnection_widget.dart';
import '../widgets/weather_container.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  CodeMapper weatherCode = CodeMapper();
  HoursParser hours = HoursParser();
  late String imagePath;
  late String cityandCountry;
  DaysForecast daysForecastWidget = DaysForecast();
  CustomPopupMenu popupMenu = CustomPopupMenu();
  NoInternetWidget nointernetWidget = NoInternetWidget();
  LocationServicesDisabled noLocationEnabledWidget = LocationServicesDisabled();
  ConditionsSeverityCalculator calcConditions = ConditionsSeverityCalculator();
  WeatherContainer weatherContainerBuild = WeatherContainer();

  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return Stack(
            children: [
              Image.asset(
                'assets/backgrounds/sunny.png',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 9.0, sigmaY: 9.0),
                child: const Center(
                  child: SpinKitThreeBounce(color: Colors.blue),
                ),
              ),
            ],
          );
        } else if (state is WeatherLoaded) {
          final weather = state.weather;
          imagePath = state.imagePath;
          cityandCountry = state.cityandCountry;
          return Stack(
            children: <Widget>[
              Image.asset(
                imagePath,
                filterQuality: FilterQuality.high,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  // actions: [popupMenu.customPopupMenuWidget()], // TODO: add popup menu later
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  scrolledUnderElevation: 0,
                ),

                body: SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final screenHeight = constraints.maxHeight;
                      final screenWidth = constraints.maxWidth;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${weather.current!.temperature2M!.round().toString()}°C',
                                    style: TextStyle(
                                      fontSize:
                                          screenWidth *
                                          0.1, // dynamic font size
                                      color: Colors.white,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.04),
                                  Column(
                                    children: [
                                      Text(
                                        'H: ${weather.daily!.temperature2MMax.first.round().toString()}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.045,
                                        ),
                                      ),
                                      Text(
                                        'L: ${weather.daily!.temperature2MMin.first.round().toString()}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.045,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: screenWidth * 0.025),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    CupertinoIcons.location_fill,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    cityandCountry,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.048,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.025),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.40),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  WeatherTimeline(
                                    times: hours.parseHours(
                                      weather.hourly!.time,
                                    ),
                                    temps: weather.hourly!.temperature2M
                                        .map((t) => t.round().toString())
                                        .toList(),
                                    description:
                                        'Feels like ${weather.current!.apparentTemperature!.round().toString()} degrees, ${weatherCode.fetchCode(weather.current!.weatherCode)}.',
                                    weatherCode: weather.hourly!.weatherCode,
                                    isDay: weather.hourly!.isDay,
                                  ).buildWidget(),
                                  SizedBox(height: screenHeight * 0.02),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      weatherContainerBuild.weatherContainer(
                                        CupertinoIcons.drop,
                                        weather.current!.isDay!,
                                        'Rain',
                                        weather.current!.rain!.toInt(),
                                        calcConditions.getRainDescription,
                                      ),
                                      weatherContainerBuild.weatherContainer(
                                        CupertinoIcons.sun_min,
                                        weather.current!.isDay!,
                                        'UV Index',
                                        weather.hourly!.uvIndex[0].toInt(),
                                        calcConditions.uvIntensity,
                                      ),
                                      weatherContainerBuild.weatherContainer(
                                        CupertinoIcons.cloud_sun,
                                        weather.current!.isDay!,
                                        'Humidity',
                                        weather.hourly!.humidityPercent[0],
                                        calcConditions.getHumidityDescription,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Weekly Forecast',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.055,
                                          fontFamily: 'Sarabun',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  daysForecastWidget.daysForecastWidget(
                                    weather.daily!.temperature2MMin,
                                    weather.daily!.temperature2MMax,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (state is NoInternetError) {
          return nointernetWidget.noConnection();
        } else if (state is LocationDisabledError) {
          return noLocationEnabledWidget.locationDisabledWidget();
        }
        return Container();
      },
    );
  }
}
