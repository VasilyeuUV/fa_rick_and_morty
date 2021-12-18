// Пользовательский ListTile

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fa_rick_and_morty/data/models/character.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Results result;
  const CustomListTile({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // - контейнер, чтобы закруглить края блоков
    return ClipRRect(
      // -- закругляем границы
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: MediaQuery.of(context).size.height / 7,
        color: const Color.fromRGBO(86, 86, 86, 0.8),
        // -- размещаем информацию
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // для загрузки картинки используем пакет cached_network_image
            CachedNetworkImage(
              imageUrl: result.image,
              // -- если картинки нет, отображаем индикатор загрузк
              placeholder: (context, url) => const CircularProgressIndicator(
                color: Colors.grey,
              ),
              // -- если картинка не загрузится
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            // отображаем информацию
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // - имя
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.9,
                    child: Text(result.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                  // - отступ
                  const SizedBox(
                    height: 10,
                  ),
                  // - специализация и пол
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // -- Species column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Species: ',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              result.species,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        // -- Gender column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender: ',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              result.gender,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
