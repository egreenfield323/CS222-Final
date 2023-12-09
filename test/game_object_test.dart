import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/game.dart';
import 'package:game_data/game_parser.dart';

void main() {
  GameParser gameCreator = GameParser();

  final testFile = File('test/minecraft.json');
  final stringData = testFile.readAsStringSync();
  final decodedJsonObject = jsonDecode(stringData);

  test('i can make a game object using createGameFromJson method', () {
    Game game = gameCreator.createGameFromJson(decodedJsonObject);
    expect(game.title, 'Minecraft');
  });
}
