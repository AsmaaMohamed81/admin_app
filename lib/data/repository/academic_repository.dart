import 'package:admin_app/data/model/academic.dart';
import 'package:admin_app/networking/api_provider.dart';
import 'package:admin_app/utils/urls.dart';
import 'package:flutter/cupertino.dart';

abstract class AcademicRepository {
  Future<List<Academic>> getAllAcademic(int schoolId);
  Future<List<Academic>> editAcademic();
  Future<Map<String, dynamic>> deleteAcademic(
      String accessToken, int idAcademic);
  Future<Map<String, dynamic>> addEditeAcademic(
      String accessToken,
      int id,
      String name,
      bool isCurrentYear,
      int schoolId,
      List<int> semestersId,
      List<String> semestersName,
      List<bool> isCurrentSemester);

  Future<Map<String, dynamic>> addEditeAcademicDelete(
      String accessToken,
      String name,
      int idAcademic,
      int choolId,
      String abbreviation,
      List<int> teachers);
}

class AcademicRepositoryImp extends AcademicRepository {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<List<Academic>> getAllAcademic(int schoolId) async {
    List<Academic> AcademicList;
    final response = await _apiProvider
        .get(Urls.Get_All_AcademicYears + "?SchoolId=$schoolId");
    print(response);
    Iterable iterable = response['data'];
    AcademicList = iterable.map((model) => Academic.fromJson(model)).toList();
    return AcademicList;
  }

  @override
  Future<Map<String, dynamic>> deleteAcademic(
      String accessToken, int idAcademic) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results = await _apiProvider
        .get(Urls.Delete_Academic_Years + "?Id=${idAcademic}", header: headers);

    return results;
  }

  @override
  Future<List<Academic>> editAcademic() {}

  @override
  Future<Map<String, dynamic>> addEditeAcademic(
      String accessToken,
      int id,
      String name,
      bool isCurrentYear,
      int schoolId,
      List<int> semestersId,
      List<String> semestersName,
      List<bool> isCurrentSemester) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results =
        await _apiProvider.post(Urls.Save_Academic_Years,
            body: {
              "id": id,
              "name": name,
              "isCurrentYear": isCurrentYear,
              "schoolId": schoolId,
              "semestersId": semestersId,
              "semestersName": semestersName,
              "isCurrentSemester": isCurrentSemester
            },
            header: headers);

    return results;
  }

  @override
  Future<Map<String, dynamic>> addEditeAcademicDelete(
      String accessToken,
      String materialname,
      int idAcademic,
      int schoolId,
      String abbreviation,
      List<int> teachers) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results =
        await _apiProvider.post(Urls.Save_Academic_Years,
            body: {
              "id": idAcademic,
              "name": materialname,
              "schoolId": schoolId,
              "abbreviation": abbreviation,
              "teachers": teachers
            },
            header: headers);

    return results;
  }
}
