import 'package:flutter/material.dart';
import 'package:game_data/favorite_games.dart';
import 'package:game_data/game.dart';

import 'game_in_list_widget.dart';

class FavoritesPage extends StatefulWidget {
  final FavoriteGames favoriteList;

  const FavoritesPage({super.key, required this.favoriteList});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView(
        children: [
          AppBar(
            title: const Text("Favorited Games"),
            centerTitle: true,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            backgroundColor: Colors.orange,
          ),
          for (Game g in widget.favoriteList.favoritesList.values)
            Row(
              children: [
                GameWidget(
                  game: g,
                  favoriteButton: ElevatedButton(
                    onPressed: () =>
                        setState(() => widget.favoriteList.setFavoriteState(g)),
                    child: Icon(widget.favoriteList.isFavorited(g)
                        ? Icons.thumb_up
                        : Icons.thumb_up_alt_outlined),
                  ),
                  favoriteGames: FavoriteGames(),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
