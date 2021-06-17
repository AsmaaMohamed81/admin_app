import 'package:admin_app/networking/api_provider.dart';
import 'package:admin_app/utils/urls.dart';
import 'package:flutter/cupertino.dart';

import '../model/years.dart';

abstract class YearsRepository {
  Future<List<Years>> getAllYears(int schoolId);
  Future<List<Years>> editYears();
  Future<Map<String, dynamic>> deleteYears(String accessToken, int idLevel);
  Future<Map<String, dynamic>> addEditeYears(String accessToken, int id,
      int schoolId, int idLevel, int academicYearId, String name);
}

class YearsRepositoryImp extends YearsRepository {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<List<Years>> getAllYears(int schoolId) async {
    List<Years> yearsList;
    final response = await _apiProvider
        .get(Urls.Get_All_AcademicYears + "?SchoolId=$schoolId");
    print("jhjkhjk${response}");
    Iterable iterable = response['data'];
    yearsList = iterable.map((model) => Years.fromJson(model)).toList();
    return yearsList;
  }

  @override
  Future<Map<String, dynamic>> deleteYears(
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
  Future<List<Years>> editYears() {}

  @override
  Future<Map<String, dynamic>> addEditeYears(String accessToken, int id,
      int schoolId, int idLevel, int academicYearId, String name) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results = await _apiProvider.post(Urls.Add_Level,
        body: {
          "id": id,
          "schoolId": schoolId,
          "levelId": idLevel,
          "academicYearId": academicYearId,
          "name": name,
        },
        header: headers);

    return results;
  }
}
