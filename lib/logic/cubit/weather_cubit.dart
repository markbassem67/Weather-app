// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:testapp/data/repositories/weather_repositry.dart';
import 'package:testapp/logic/cubit/weather_state.dart';

import '../../core/errors/custom_exceptions.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository repository;

  WeatherCubit(this.repository) : super(WeatherInitial());

  Future<void> getWeather() async {
    emit(WeatherLoading());
    try {
      final weather = await repository.fetchWeather();
      final int? isDay = weather.current!.isDay;
      final bool isDayTime = isDay == 1;
      final String imagePath = isDayTime
          ? 'assets/backgrounds/sunny.png'
          : 'assets/backgrounds/night.png';
      final String cityandCountry = await repository.getCityAndCountry(
        weather.latitude!,
        weather.longitude!,
      );
      emit(WeatherLoaded(weather, imagePath, cityandCountry));
    } on LocationDisabledException {
      emit(LocationDisabledError());
    } on NoInternetException {
      emit(NoInternetError());
    } on UnknownWeatherException catch (e) {
      emit(UnknownError(e.message));
    }
  }
}
