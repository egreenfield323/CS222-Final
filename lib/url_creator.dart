import 'dart:io';

class UrlCreator {
  final String _key = File("secrets/key.txt").readAsStringSync();

  String createSpecificQueryUrl(String gameTitle) {
    if (gameTitle.contains(' ')) {
      gameTitle = gameTitle.replaceAll(' ', '-');
    }
    if (gameTitle.contains(':')) {
      gameTitle = gameTitle.replaceAll(':', '');
    }
    if (gameTitle.contains(';')) {
      gameTitle = gameTitle.replaceAll(';', '');
    }
    if (gameTitle.contains('\'')) {
      gameTitle = gameTitle.replaceAll('\'', '');
    }
    return 'https://api.rawg.io/api/games/$gameTitle?stores=1,2,3,4,5,6,7,8,11&key=$_key';
  }

  String createUpcomingGamesQueryUrl() {
    String currentDate = DateTime.now().toString().split(' ')[0];
    String endDate =
        DateTime.now().add(const Duration(days: 365)).toString().split(' ')[0];
    return 'https://api.rawg.io/api/games?dates=$currentDate,$endDate&stores=1,2,3,4,5,6,7,8,11&ordering=released&key=$_key';
  }
}
