import 'package:flutter/material.dart';
import 'package:game_data/favorite_games.dart';
import 'package:game_data/game_parser.dart';

import '../game.dart';

class GamePage extends StatefulWidget {
  final Game game;
  final FavoriteGames favoriteGames;
  final ElevatedButton? favoriteButton;

  const GamePage(this.game, this.favoriteGames,
      {super.key, this.favoriteButton});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    final favoriteButton = ElevatedButton(
      onPressed: () => setState(
        () => widget.favoriteGames.setFavoriteState(widget.game),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.favoriteGames.isFavorited(widget.game)
                ? Icons.thumb_up
                : Icons.thumb_up_alt_outlined,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            widget.favoriteGames.isFavorited(widget.game)
                ? 'Favorited'
                : 'Favorite',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.blueGrey,
              ),
              child: const Text(
                "Back",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 450,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.game.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            //title
            SizedBox(
              child: Text(
                widget.game.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            //release date
            SizedBox(
              child: Text(
                GameParser().getGameReleaseDateString(widget.game.releaseDate),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            //game rating
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, size: 24, color: Colors.amber),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.game.rating}/100',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            //game description
            SizedBox(
              width: double.infinity,
              child: Text(
                widget.game.description,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'Arial',
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (widget.favoriteButton == null) favoriteButton,
          ],
        ),
      ),
    );
  }
}
