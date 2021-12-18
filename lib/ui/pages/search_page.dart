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

    return state.when(
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
        error: () => const Text('Nothing found...'));
  }
}
