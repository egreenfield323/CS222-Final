import 'package:flutter/material.dart';
import 'package:game_data/favorite_games.dart';
import 'package:game_data/game.dart';
import 'package:game_data/game_parser.dart';
import 'package:game_data/widgets/game_page_widget.dart';

class GameWidget extends StatefulWidget {
  final Game game;
  final ElevatedButton favoriteButton;
  final FavoriteGames favoriteGames;

  const GameWidget({
    super.key,
    required this.game,
    required this.favoriteButton,
    required this.favoriteGames,
  });

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  GameParser gameParser = GameParser();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => displayGamePage(widget.game),
          child: Row(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Image.network(widget.game.imageUrl),
              ),
              Column(
                children: [
                  SizedBox(
                    width: 600,
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        widget.game.title,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 200,
                    height: 10,
                  ),
                  SizedBox(
                    width: 600,
                    height: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(gameParser
                          .getGameReleaseDateString(widget.game.releaseDate)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        widget.favoriteButton,
      ],
    );
  }

  //use navigator to display a game page widget
  void displayGamePage(Game game) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GamePage(
          widget.game,
          widget.favoriteGames,
          favoriteButton: widget.favoriteButton,
        ),
      ),
    );
  }
}
