// Реализация управления состоянием в приложении.
// Файл будет отвечать за события

// ссылка на файл реализации bloc
part of 'character_bloc.dart';

/// Класс с событиями
@freezed
class CharacterEvent with _$CharacterEvent {
  /// CTOR (используем union-классы)
  const factory CharacterEvent.fetch({
    // - поля, которые мы будем использовать в запросе
    required String name,
    required int page,
  }) = CharacterEventFetch;
}


/*
После создания классf, запустить в терминале команду:
flutter pub run build_runner watch --delete-conflicting-outputs

будут сгенерированы необходимые файлы, 
*/