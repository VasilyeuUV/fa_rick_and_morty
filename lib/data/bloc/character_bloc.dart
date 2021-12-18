/// Реализация управления состоянием в приложении.
/// Реализация bloc с помощью библиотеки freezed

import 'package:fa_rick_and_morty/data/models/character.dart';
import 'package:fa_rick_and_morty/data/repositories/character_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

// Файлы, в которые будет генерироваться весь наш код
part 'character_bloc.freezed.dart';
part 'character_bloc.g.dart';
part 'character_event.dart'; // будем ссылаться на наши события
part 'character_state.dart'; // будем ссылаться на наши состояния

/// Реализовывать bloc будем с помощью библиотеки flutter_bloc
/// Потом Bloc расширим HydratedBloc из пакета hydrated_bloc
/// для реализации кэширования
class CharacterBloc extends Bloc<CharacterEvent, CharacterState>
    with HydratedMixin {
  /// Репозиторий
  final CharacterRepository characterRepository;

  /// CTOR
  /// в super передаем первое состояние
  CharacterBloc({required this.characterRepository})
      : super(const CharacterState.loading()) {
    // - зарегистрируем наше событие,
    // и в зависимости от события будем эммитить нужное нам состояние
    on<CharacterEventFetch>((event, emit) async {
      // -- когда приложение загружается, эмиттим состояние loading
      emit(const CharacterState.loading());

      // -- когда всё загрузится, эмиттим состояние loaded
      // -- и в параметр loaded передаём наши персонажи,
      // -- полученные из репозитория
      try {
        Character _characterLoaded = await characterRepository
            .getCharacter(event.page, event.name)
            // -- таймаут в 5 секунд для загрузки, чтобы не подвисло при ошибке
            .timeout(const Duration(seconds: 5));
        emit(CharacterState.loaded(characterLoaded: _characterLoaded));
      } catch (_) {
        // -- если что-то не так, эмиттим состояние error
        emit(const CharacterState.error());

        // -- чтобы отправить ошибки в bloc_observable.dart
        // -- отправляем её дальше
        rethrow;
      }
    });
  }

  // ОБЯЗАТЕЛЬНЫЕ МЕТОДЫ пакета hydrated_bloc

  /// Отвечает за восстановление состояния
  @override
  CharacterState? fromJson(Map<String, dynamic> json) =>
      CharacterState.fromJson(json);

  /// Отвечает за сохранение состояния на устройство
  @override
  Map<String, dynamic>? toJson(CharacterState state) => state.toJson();
}
