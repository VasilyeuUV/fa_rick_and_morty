// Отслеживание событий и ошибок
// будет отображаться в Терминал в Консоли отладки

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterBlocObservable extends BlocObserver {
  // для отслеживания событий переопределяем метод
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    // - блок у которого произошло событие
    log('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  // для отслеживания ошибок переопределяем метод
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    // - при получении ошибки, выводим её в консоль
    log('onError -- bloc: ${bloc.runtimeType}, event: $error');
    // сюда можнго подключить CrushLitics или FairBaseAnalytics
    // куда будут капать ошибки со всего приложения
  }
}
