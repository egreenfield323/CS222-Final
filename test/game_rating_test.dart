import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/game_parser.dart';

void main() {
  GameParser gameCreator = GameParser();

  final testFile = File('test/minecraft.json');
  final stringData = testFile.readAsStringSync();
  final decodedJsonObject = jsonDecode(stringData);

  test("i can get the metacritic rating of a game using getGameRating", () {
    int expected = gameCreator.getGameRating(decodedJsonObject);
    expect(expected, 83);
  });
}
