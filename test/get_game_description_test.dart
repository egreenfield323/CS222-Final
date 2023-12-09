import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/game_parser.dart';

void main() {
  GameParser gameCreator = GameParser();

  final testFile = File('test/minecraft.json');
  final stringData = testFile.readAsStringSync();
  final decodedJsonObject = jsonDecode(stringData);

  test("I can get the description of a game without the html tags", () {
    String expected = gameCreator.getGameDescription(decodedJsonObject);
    expect(expected, startsWith("One of the most popular games"));
  });
}
