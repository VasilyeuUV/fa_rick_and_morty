// Чтобы выполнить запрос, используют пакет HTTP

import 'dart:convert';

import 'package:fa_rick_and_morty/data/models/character.dart';
import 'package:http/http.dart' as http; // подключение пакета http

class CharacterRepository {
  /// Get point на API
  final url = 'https://rickandmortyapi.com/api/character';

  /// Метод для получения данных с API
  /// page - для получения доступа к страницам
  /// name - имя искомого персонажа
  Future<Character> getCharacter(int page, String name) async {
    try {
      // запрос к API по url, к которому добавили параметры page и name
      // получили json
      var response = await http.get(Uri.parse(url + '?page=$page&name=$name'));

      // декодируем тело json из API
      var jsonResult = json.decode(response.body);
      // передаем результат json в модель
      return Character.fromJson(jsonResult);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
