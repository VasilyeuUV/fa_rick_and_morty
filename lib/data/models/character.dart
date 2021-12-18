import 'package:freezed_annotation/freezed_annotation.dart';

/// Объявляем файлы, в которых будет содержаться сгенерированный код
/// от пакета Freezed и пакета JSON
part 'character.freezed.dart';
part 'character.g.dart';

@freezed // помечаем класс аннотацией freezed
class Character with _$Character {
  // реализуем класс с импользованием Freezed
  /// CTOR
  const factory Character({
    required Info info,
    required List<Results> results,
  }) = _Character;

  // реализуем FromJSON (генерится с помощью пакета json_serializable)
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}

/// Класс содержит информацию
@freezed
class Info with _$Info {
  /// CTOR
  const factory Info({
    required int count,
    required int pages,
    String? next,
    String? prev,
  }) = _Info;

  // реализуем FromJSON (генерится с помощью пакета json_serializable)
  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}

/// Класс о персонажах
@freezed
class Results with _$Results {
  /// CTOR
  const factory Results({
    required int id,
    required String name,
    required String status,
    required String species,
    required String gender,
    required String image,
  }) = _Results;

  // реализуем FromJSON (генерится с помощью пакета json_serializable)
  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
}


/*
После создания в классов, запустить в терминале команду:
flutter pub run build_runner watch --delete-conflicting-outputs

будут сгенерированы 2 объявленных файла, 
которые содержат необходимый функционал для работы с JSON.
*/