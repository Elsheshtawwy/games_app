import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:games_app/models/GameCardModel.dart';
import 'package:games_app/models/GameDetailsModel.dart';
import 'package:http/http.dart' as http;

class GamesProvider with ChangeNotifier {
  GameDetailsModel? detailedGameModel;
  bool isLoading = false;
  List<GameModel> similarGames = [];

  fetchGameById(String id) async {
    isLoading = true;
    notifyListeners();

    final response =
        await http.get(Uri.parse("https://www.freetogame.com/api/game?id=$id"));

    if (kDebugMode) {
      print("REQUEST ON URL : https://www.freetogame.com/api/game?id=$id");
      print("STATUS CODE : ${response.statusCode}");
      print("BODY : ${response.body}");
    }

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      detailedGameModel = GameDetailsModel.fromJson(decodedData);
      getGamesByCategory(detailedGameModel!.genre);
    }
    isLoading = false;
    notifyListeners();
  }

  getGamesByCategory(String category) async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(
        Uri.parse("https://www.freetogame.com/api/games?category=$category"));

    if (kDebugMode) {
      print("STATUS CODE : ${response.statusCode}");
      print("BODY : ${response.body}");
    }

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      similarGames =
          List<GameModel>.from(decodedData.map((e) => GameModel.fromJson(e)))
              .toList();
    }

    isLoading = false;
    notifyListeners();
  }

//Home

  List<GameModel> games = [];

  fetchGames(String platform) async {
    isLoading = true;
    notifyListeners();

    games.clear();
    final response = await http.get(
        Uri.parse("https://www.freetogame.com/api/games?platform=$platform"));

    if (kDebugMode) {
      print("STATUS CODE : ${response.statusCode}");
      print("BODY : ${response.body}");
    }

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      games =
          List<GameModel>.from(decodedData.map((e) => GameModel.fromJson(e)))
              .toList();

      isLoading = false;
      notifyListeners();
    }
  }
}
