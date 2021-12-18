// Для отображения статуса персонажа (жив он или нет)

import 'package:flutter/material.dart';

/// Статусы персонажа: жив, мёртв, неизвестно
enum LiveState { alive, dead, unknow }

/// Виджет отображения статуса персонажа
class CharacterStatus extends StatelessWidget {
  /// текущее состояние персонажа
  final LiveState liveState;
  const CharacterStatus({Key? key, required this.liveState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // - иконка
        Icon(
          // - закруглённая
          Icons.circle,
          size: 11,
          // - цвет в зависимости от состояния персонажа
          color: liveState == LiveState.alive
              ? Colors.lightGreenAccent[400]
              : liveState == LiveState.dead
                  ? Colors.red
                  : Colors.white,
        ),
        // - отступ
        const SizedBox(width: 6),
        // - текст в зависимости от состояния персонажа
        Text(
          liveState == LiveState.dead
              ? 'Dead'
              : liveState == LiveState.alive
                  ? 'Alive'
                  : 'Unknow',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
