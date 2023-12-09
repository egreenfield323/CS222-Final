import 'package:flutter/material.dart';
import 'package:game_data/favorite_games.dart';
import 'package:game_data/game.dart';
import 'package:game_data/game_parser.dart';
import 'package:game_data/json_decoder.dart';
import 'package:game_data/url_creator.dart';
import 'package:game_data/widgets/game_page_widget.dart';

class SearchPage extends StatefulWidget {
  final FavoriteGames favoriteGames;

  const SearchPage({super.key, required this.favoriteGames});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  String search = "";
  Game? game;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    bool isSearchEnabled = controller.text.isNotEmpty;

    if (game == null) {
      return Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: AppBar(
              title: const Text("Search Page"),
              centerTitle: true,
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              backgroundColor: Colors.lightGreen,
            ),
          ),
          const SizedBox(
            height: 150,
          ),
          const Text(
            'Enter a game title in the box below.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Container(
            width: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              textAlign: TextAlign.center,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter game name',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
              onChanged: (value) {
                setState(() {
                  isSearchEnabled = value.isNotEmpty;
                });
              },
              onSubmitted:
                  isSearchEnabled ? (search) => _searchForGame() : null,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isSearchEnabled ? () => _searchForGame() : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 30,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Search',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      );
    } else {
      game = null;
      return SearchPage(favoriteGames: widget.favoriteGames);
    }
  }

  Future<void> _searchForGame() async {
    final urlCreator = UrlCreator();
    final jsonDecoder = JsonDecoder();
    final gameParser = GameParser();
    search = controller.text;
    search = search.replaceAll('/', '').replaceAll('\\', '');
    String gameUrl = urlCreator.createSpecificQueryUrl(search.toLowerCase());
    var jsonData = await jsonDecoder.decodeJsonFromUrl(gameUrl);
    if (jsonData['detail'] == 'Not found.') {
      setState(() {
        errorMessage = 'Could not find game "$search"';
      });
    } else {
      if (jsonData['redirect'] == true) {
        gameUrl = urlCreator.createSpecificQueryUrl(jsonData['slug']);
        jsonData = await jsonDecoder.decodeJsonFromUrl(gameUrl);
      }
      setState(() {
        errorMessage = '';
        game = gameParser.createGameFromJson(jsonData);
      });
    }
    if (game == null && mounted) {
      setState(() {
        errorMessage = 'Could not find game "$search"';
      });
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => GamePage(game!, widget.favoriteGames)));
    }
  }
}
