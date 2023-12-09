import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/game.dart';
import 'package:game_data/game_parser.dart';

void main() {
  GameParser gameParser = GameParser();

  final testFile = File('test/minecraft.json');
  final stringData = testFile.readAsStringSync();
  final decodedJsonObject = jsonDecode(stringData);
  Game minecraft = Game(
      decodedJsonObject["name"],
      decodedJsonObject["description"],
      decodedJsonObject["metacritic"],
      DateTime.parse(decodedJsonObject["released"]),
      decodedJsonObject["background_image"]);

  test("if the release date is 2009-05-10, getMonthName will return 'May.'",
      () {
    String expected = gameParser.getMonthName(minecraft.releaseDate);
    expect(expected, "May");
  });

  test(
      "if the release date is 2009-05-10, getGameReleaseDateString will return May 10, 2009",
      () {
    String expected =
        gameParser.getGameReleaseDateString(minecraft.releaseDate);
    expect(expected, "May 10, 2009");
  });
}
