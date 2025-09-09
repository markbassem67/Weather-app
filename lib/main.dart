import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/core/network/weather_api_service.dart';
import 'package:testapp/data/repositories/weather_repositry.dart';
import 'package:testapp/logic/cubit/weather_cubit.dart';
import 'package:testapp/presentation/screens/weather_screen.dart';

import 'core/services/location_services.dart';
import 'core/services/reverse_geocoding_service.dart';

void main() {
  final weatherService = ObtainWeather();
  final locationService = LocationServices();
  final reversegoecode = ReverseGeocodingService();
  final weatherRepository = WeatherRepository(
    weatherService,
    locationService,
    reversegoecode,
  );

  runApp(
    BlocProvider(
      create: (_) => WeatherCubit(weatherRepository),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const WeatherScreen(),
    );
  }
}
