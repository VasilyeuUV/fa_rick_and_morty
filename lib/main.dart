import 'package:fa_rick_and_morty/data/bloc_observable.dart';
import 'package:fa_rick_and_morty/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

/// Метод main будет асинхронным, т.к. мы работаем с хранилищем.
void main() async {
  /// Виджет используется для взаимодействия с движком Flutter
  /// т.е. соединяет фреймворк и движок Flutter
  /// нужен для path_provider. При создании хранилищ на устройствах Android или IoS
  /// пакет будет использовать каналы платформы для вызова собственного кода,
  /// который будет выполняться асинхронно
  WidgetsFlutterBinding.ensureInitialized();

  /// Хранилище, куда будет сохраняться наше состояние
  /// TemporaryDirectory находится в path_provider
  final storage = await HydratedStorage.build(
      // - указываем, что будем хранить состояние
      // - во временных папках на устройстве
      storageDirectory: await getTemporaryDirectory());

  HydratedBlocOverrides.runZoned(
    // - запускаем приложение
    () => runApp(const App()),
    // - подключаем отслеживание bloc_observable.dart
    blocObserver: CharacterBlocObservable(),
    // - подключаем хранилище
    storage: storage,
  );

// // подключаем отслеживание bloc_observable.dart
//   BlocOverrides.runZoned(
//     () => runApp(const App()),
//     blocObserver: CharacterBlocObservable(),
//   );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
          headline2: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
          headline3: TextStyle(fontSize: 24.0, color: Colors.white),
          bodyText2: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
          bodyText1: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.w200, color: Colors.white),
          caption: TextStyle(
              fontSize: 11.0, fontWeight: FontWeight.w100, color: Colors.grey),
        ),
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Rick and Morty'),
    );
  }
}
