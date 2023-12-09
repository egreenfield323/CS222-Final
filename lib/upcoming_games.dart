import 'package:game_data/game.dart';
import 'package:game_data/json_decoder.dart';
import 'package:game_data/url_creator.dart';

import 'game_parser.dart';

class UpcomingGames {
  List<Game> upcomingGamesList = [];
}

class UpcomingGamesListFetcher {
  List<Game> upcoming = [];

  List<String> createListOfSlugs(var gameJsonData) {
    List<String> listOfGameSlugs = [];
    for (int i = 0; i < gameJsonData['results'].length; i++) {
      String slug = gameJsonData['results'][i]['slug'];
      listOfGameSlugs.add(slug);
    }
    return listOfGameSlugs;
  }

  Future<List<Game>> createListOfGames(var listOfSlugs) async {
    List<Game> listOfGames = [];

    UrlCreator urlCreator = UrlCreator();
    JsonDecoder jsonDecoder = JsonDecoder();
    GameParser gameParser = GameParser();

    for (int i = 0; i < listOfSlugs.length; i++) {
      String url = urlCreator.createSpecificQueryUrl(listOfSlugs[i]);
      final jsonData = await jsonDecoder.decodeJsonFromUrl(url);
      listOfGames.add(gameParser.createGameFromJson(jsonData));
    }
    return listOfGames;
  }
}
