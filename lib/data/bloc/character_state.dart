/// Реализация управления состоянием в приложении.
/// Файл будет отвечать за состояния

// ссылка на файл реализации bloc
part of 'character_bloc.dart';

/// Класс с состояниями
@freezed
class CharacterState with _$CharacterState {
  /// CTOR (используем union-классы)

  /// - 1-е состояние - Процесс загрузки
  const factory CharacterState.loading() = CharacterStateLoading;

  /// - 2-е состояние - Отвечает за успешную загрузку
  const factory CharacterState.loaded(
      {
      // -- в качестве параметра - Модель
      required Character characterLoaded}) = CharacterStateLoaded;

  /// - 3-е состояние - При возникновении ошибки
  const factory CharacterState.error() = CharacterStateError;

  // ДАЛЕЕ ДЛЯ КЭШИРОВАНИЯ

  factory CharacterState.fromJson(Map<String, dynamic> json) =>
      _$CharacterStateFromJson(json);
}



/*
После создания класса и при каждом изменении, запустить в терминале команду:
flutter pub run build_runner watch --delete-conflicting-outputs

будут сгенерированы необходимые файлы, 
*/