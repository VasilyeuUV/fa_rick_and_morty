// Страница поиска
// При запуске приложения здесь будем получать данные о персонажах

import 'package:fa_rick_and_morty/data/bloc/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
// При инициализации состояния
// лучшее место для первичного запроса к API Rick and Morty
  @override
  void initState() {
    context
        .read<CharacterBloc>()
        // обращаемся к нашему событию
        .add(const CharacterEvent.fetch(name: '', page: 1));
    super.initState();
  }

// В зависимости от состояний будем менять пользовательский интерфейс
// для этого будем использовать паттерн Matching,
// который реализован в пакете freezed

  /// Обработка состояний
  @override
  Widget build(BuildContext context) {
    /// state будет получать состояния из нашего bloc
    /// состояние отслеживаем через метод watch
    final state = context.watch<CharacterBloc>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // - отступы для строки поиска
        Padding(
          padding: const EdgeInsets.all(5.0),
          // - строка поиска
          child: TextField(
            // -- текст текста
            style: const TextStyle(color: Colors.white),
            // -- цвет курсора
            cursorColor: Colors.white,
            // -- параметры оформления
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(86, 86, 86, 0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              // -- отображение иконки
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              // -- текст подсказки
              hintText: 'Search Name',
              // -- стиль подсказки
              hintStyle: const TextStyle(color: Colors.white),
            ),

            /// Cобытие изменения текста
            /// value - значение в строке поиска
            onChanged: (value) {
              // -- при осуществлении поиска обращаемся к нашему событию
              context
                  .read<CharacterBloc>()
                  .add(CharacterEvent.fetch(name: value, page: 1));
            },
          ),
        ),
        state.when(
            // - состояние процесса загрузки персонажа
            loading: () => Center(
                  child: Row(
                    // -- размещаем строку посередине
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // -- индикатор загрузки персонажа
                      CircularProgressIndicator(strokeWidth: 2),
                      // -- отступ вправо
                      SizedBox(width: 10),
                      Text('Loading...'),
                    ],
                  ),
                ),
            loaded: (characterLoaded) => Text('${characterLoaded.info}'),

            // - состояние ошибки
            error: () => const Text('Nothing found...')),
      ],
    );
  }
}
