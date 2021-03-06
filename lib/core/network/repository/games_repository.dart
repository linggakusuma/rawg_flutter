import 'package:flutter/cupertino.dart';
import 'package:rawg_flutter/core/network/model/games.dart';
import 'package:rawg_flutter/core/network/model/results.dart';
import 'package:rawg_flutter/core/network/repository/remote/api_repository.dart';
import 'package:rawg_flutter/core/network/repository/repository.dart';

class GamesRepository implements Repository {
  final ApiRepository apiRepository;

  static final GamesRepository _singleton =
      GamesRepository._internal(apiRepository: ApiRepository());

  factory GamesRepository() {
    return _singleton;
  }

  GamesRepository._internal({@required this.apiRepository});

  @override
  Future<Result> getGames() async {
    return await apiRepository.getGames();
  }

  @override
  Future<Games> getDetailGames(int id) async {
    return await apiRepository.getDetailGames(id);
  }

  @override
  Future<Result> getSuggestedGames(int id) async {
    return await apiRepository.getSuggestedGames(id);
  }
}
