import 'dart:convert';

import 'package:intl/intl.dart';

import 'game.dart';

class GameParser {
  Game createGameFromJson(final jsonData) {
    String name = jsonData["name"];
    String description = getGameDescription(jsonData);
    int rating = getGameRating(jsonData);
    DateTime releaseDate = getGameReleaseDate(jsonData);
    String imageUrl = getImageUrl(jsonData);

    return Game(name, description, rating, releaseDate, imageUrl);
  }

  int getGameRating(jsonData) {
    if (jsonData["metacritic"] != null) {
      return jsonData["metacritic"];
    } else {
      return 0;
    }
  }

  DateTime getGameReleaseDate(jsonData) {
    if (jsonData["released"] != null) {
      return DateTime.parse(jsonData["released"]);
    }
    return DateTime(0);
  }

  String getImageUrl(jsonData) {
    if (jsonData["background_image"] == null) {
      return 'https://t4.ftcdn.net/jpg/02/51/95/53/360_F_251955356_FAQH0U1y1TZw3ZcdPGybwUkH90a3VAhb.jpg';
    } else {
      return jsonData["background_image"];
    }
  }

  String getGameDescription(jsonData) {
    String gameDescription = jsonData["description"];

    gameDescription = gameDescription.replaceAll("&#39;", "'");
    gameDescription = gameDescription.replaceAll("&amp;", "&");
    gameDescription = gameDescription.replaceAll("&apos;", "'");
    gameDescription = gameDescription.replaceAll("&lt;", ">");
    gameDescription = gameDescription.replaceAll("&gt;", "<");
    gameDescription = gameDescription.replaceAll("</p>", "\n");
    gameDescription = gameDescription.replaceAll("<h1>", "\n\n");
    gameDescription = gameDescription.replaceAll("<h2>", "\n\n");
    gameDescription = gameDescription.replaceAll("<h3>", "\n\n");
    gameDescription = gameDescription.replaceAll("<li>", "\n- ");

    gameDescription = utf8.decode(gameDescription.runes.toList());
    gameDescription = Bidi.stripHtmlIfNeeded(gameDescription);
    gameDescription = gameDescription.trim();

    return gameDescription;
  }

  String getGameReleaseDateString(DateTime date) {
    if (date.year != 0) {
      String monthString = getMonthName(date);
      return "$monthString ${date.day.toString()}, ${date.year.toString()}";
    } else {
      return "Release date not announced";
    }
  }

  String getMonthName(DateTime date) {
    switch (date.month.toString()) {
      case "1":
        return "January";
      case "2":
        return "February";
      case "3":
        return "March";
      case "4":
        return "April";
      case "5":
        return "May";
      case "6":
        return "June";
      case "7":
        return "July";
      case "8":
        return "August";
      case "9":
        return "September";
      case "10":
        return "October";
      case "11":
        return "November";
      case "12":
        return "December";
    }
    return '';
  }
}
