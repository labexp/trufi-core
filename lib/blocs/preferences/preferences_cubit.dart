import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong/latlong.dart';
import 'package:trufi_core/blocs/preferences/preferences.dart';
import 'package:trufi_core/models/menu/menu_item.dart';
import 'package:trufi_core/repository/entities/weather_info.dart';
import 'package:trufi_core/repository/local_repository.dart';
import 'package:trufi_core/repository/shared_preferences_repository.dart';
import 'package:trufi_core/repository/wfs_weather_data_repository.dart';
import 'package:uuid/uuid.dart';

class PreferencesCubit extends Cubit<PreferenceState> {
  LocalRepository localRepository = SharedPreferencesRepository();
  final LatLng currentLocation;
  final List<List<MenuItem>> menuItems;
  final bool showWeather;

  PreferencesCubit(
      PreferenceState initState, this.menuItems, this.currentLocation,
      {this.showWeather})
      : super(initState) {
    _load();
  }

  Future<void> _load() async {
    String correlationId = await localRepository.getCorrelationId();
    WeatherInfo weatherInfo;

    if (showWeather) {
      weatherInfo = await WFSWeatherDataRepository()
          .getCurrentWeatherAtLocation(DateTime.now(), currentLocation);
    }

    // Generate new UUID if missing
    if (correlationId == null) {
      correlationId = const Uuid().v4();
      await localRepository.saveCorrelationId(correlationId);
    }

    emit(
      state.copyWith(
        correlationId: correlationId,
        languageCode: await localRepository.getLanguageCode(),
        weatherInfo: weatherInfo,
      ),
    );
  }

  Future<void> updateLanguage(String languageCode) async {
    localRepository.saveLanguageCode(languageCode);
    emit(state.copyWith(languageCode: languageCode));
  }
}
