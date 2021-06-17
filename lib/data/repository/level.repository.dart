import 'package:admin_app/networking/api_provider.dart';
import 'package:admin_app/utils/urls.dart';
import 'package:flutter/cupertino.dart';

import '../model/level.dart';

abstract class LevelRepository {
  Future<List<Levels>> getAllLevels(int schoolId);
  Future<List<Levels>> editLevels();
  Future<Map<String, dynamic>> deleteLevels(String accessToken, int idLevel);
  Future<Map<String, dynamic>> addEditeLevels(
      String accessToken, String name, int idLevel, int choolId);
}

class LevelsRepositoryImp extends LevelRepository {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<List<Levels>> getAllLevels(int schoolId) async {
    List<Levels> levelList;
    final response =
        await _apiProvider.get(Urls.Get_All_Levels + "?SchoolId=$schoolId");
    print(response);
    Iterable iterable = response['data'];
    levelList = iterable.map((model) => Levels.fromJson(model)).toList();
    return levelList;
  }

  @override
  Future<Map<String, dynamic>> deleteLevels(
      String accessToken, int idLevel) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results = await _apiProvider
        .get(Urls.Delete_Level + "?Id=${idLevel}", header: headers);

    return results;
  }

  @override
  Future<List<Levels>> editLevels() {}

  @override
  Future<Map<String, dynamic>> addEditeLevels(
      String accessToken, String name, int idLevel, int schoolId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results = await _apiProvider.post(Urls.Add_Level,
        body: {
          "id": idLevel,
          "name": name,
          "schoolId": schoolId,
        },
        header: headers);

    return results;
  }
}
