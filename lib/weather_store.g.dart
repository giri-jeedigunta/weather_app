// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WeatherStore on _WeatherStore, Store {
  final _$latitudeAtom = Atom(name: '_WeatherStore.latitude');

  @override
  double get latitude {
    _$latitudeAtom.context.enforceReadPolicy(_$latitudeAtom);
    _$latitudeAtom.reportObserved();
    return super.latitude;
  }

  @override
  set latitude(double value) {
    _$latitudeAtom.context.conditionallyRunInAction(() {
      super.latitude = value;
      _$latitudeAtom.reportChanged();
    }, _$latitudeAtom, name: '${_$latitudeAtom.name}_set');
  }

  final _$longitudeAtom = Atom(name: '_WeatherStore.longitude');

  @override
  double get longitude {
    _$longitudeAtom.context.enforceReadPolicy(_$longitudeAtom);
    _$longitudeAtom.reportObserved();
    return super.longitude;
  }

  @override
  set longitude(double value) {
    _$longitudeAtom.context.conditionallyRunInAction(() {
      super.longitude = value;
      _$longitudeAtom.reportChanged();
    }, _$longitudeAtom, name: '${_$longitudeAtom.name}_set');
  }

  final _$todaysWeatherAtom = Atom(name: '_WeatherStore.todaysWeather');

  @override
  Map<dynamic, dynamic> get todaysWeather {
    _$todaysWeatherAtom.context.enforceReadPolicy(_$todaysWeatherAtom);
    _$todaysWeatherAtom.reportObserved();
    return super.todaysWeather;
  }

  @override
  set todaysWeather(Map<dynamic, dynamic> value) {
    _$todaysWeatherAtom.context.conditionallyRunInAction(() {
      super.todaysWeather = value;
      _$todaysWeatherAtom.reportChanged();
    }, _$todaysWeatherAtom, name: '${_$todaysWeatherAtom.name}_set');
  }

  final _$fiveDayWeatherForecastAtom =
      Atom(name: '_WeatherStore.fiveDayWeatherForecast');

  @override
  Map<dynamic, dynamic> get fiveDayWeatherForecast {
    _$fiveDayWeatherForecastAtom.context
        .enforceReadPolicy(_$fiveDayWeatherForecastAtom);
    _$fiveDayWeatherForecastAtom.reportObserved();
    return super.fiveDayWeatherForecast;
  }

  @override
  set fiveDayWeatherForecast(Map<dynamic, dynamic> value) {
    _$fiveDayWeatherForecastAtom.context.conditionallyRunInAction(() {
      super.fiveDayWeatherForecast = value;
      _$fiveDayWeatherForecastAtom.reportChanged();
    }, _$fiveDayWeatherForecastAtom,
        name: '${_$fiveDayWeatherForecastAtom.name}_set');
  }

  final _$updateLocationAsyncAction = AsyncAction('updateLocation');

  @override
  Future<void> updateLocation() {
    return _$updateLocationAsyncAction.run(() => super.updateLocation());
  }

  final _$updateWeatherAndForecastAsyncAction =
      AsyncAction('updateWeatherAndForecast');

  @override
  Future<void> updateWeatherAndForecast(double lat, double long) {
    return _$updateWeatherAndForecastAsyncAction
        .run(() => super.updateWeatherAndForecast(lat, long));
  }
}
