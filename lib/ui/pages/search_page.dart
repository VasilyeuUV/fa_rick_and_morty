// Страница поиска
// При запуске приложения здесь будем получать данные о персонажах

import 'package:fa_rick_and_morty/data/bloc/character_bloc.dart';
import 'package:fa_rick_and_morty/data/models/character.dart';
import 'package:fa_rick_and_morty/ui/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  /// Вся информация об общем количестве страниц и персонажах
  late Character _currentCharacter;

  /// Массив персонажей
  List<Results> _currentResults = [];

  /// Текущая страница + для пагинации (подзагрузки персонажей)
  int _currentPage = 1;

  /// Текущая строка для поиска, которую ввёл пользователь
  String _currentSearchString = '';

  // При инициализации состояния
  // лучшее место для первичного запроса к API Rick and Morty
  @override
  void initState() {
    // - если результат пустой, загружаем данные с сайта
    if (_currentResults.isEmpty) {
      context
          .read<CharacterBloc>()
          // -- обращаемся к нашему событию
          .add(const CharacterEvent.fetch(name: '', page: 1));
    }

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
              // - при любом изменении в строке поиска
              // - начинаем искать с 1-й страницы
              _currentPage = 1;

              // - перед каждым новым поиском очищаем предыдущий результат
              _currentResults = [];

              /// Сюда передаём то, что ввёл пользователь
              _currentSearchString = value;

              // -- при осуществлении поиска обращаемся к нашему событию
              context
                  .read<CharacterBloc>()
                  .add(CharacterEvent.fetch(name: value, page: _currentPage));
            },
          ),
        ),
        Expanded(
          child: state.when(
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
              loaded: (characterLoaded) {
                _currentCharacter = characterLoaded;
                _currentResults = _currentCharacter.results;
                // -- отображаем результат загрузки
                return _currentResults.isNotEmpty
                    // -- отображаем список
                    ? _customListView(_currentResults)
                    // -- иначе ничего не отображаем
                    : const SizedBox();
              },

              // - состояние ошибки
              error: () => const Text('Nothing found...')),
        ),
      ],
    );
  }

  Widget _customListView(List<Results> currentResults) {
    return ListView.separated(
      itemCount: currentResults.length,
      // - разделитель между карточками результата
      // - _ - первый параметр не принимаем
      separatorBuilder: (_, index) => const SizedBox(height: 5),
      // - чтобы ListView занимал только нужное пространство
      //-  в зависимости от количества элементов, а не всё
      shrinkWrap: true,
      // - создание пункта
      itemBuilder: (context, index) {
        final result = currentResults[index];
        return Padding(
          padding:
              const EdgeInsets.only(right: 16, left: 16, top: 3, bottom: 3),
          child: CustomListTile(result: result),
        );
      },
    );
  }
}
