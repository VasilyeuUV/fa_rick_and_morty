// Пользовательский ListTile

import 'package:fa_rick_and_morty/data/models/character.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Results result;
  const CustomListTile({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // -- отображаемое название
      title: Text(
        result.name,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
