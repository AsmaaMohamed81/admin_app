import 'package:admin_app/data/model/subjects.dart';
import 'package:admin_app/networking/api_provider.dart';
import 'package:admin_app/utils/urls.dart';
import 'package:flutter/cupertino.dart';

abstract class SubjectsRepository {
  Future<List<Subjects>> getAllSubjects(int schoolId);
  Future<List<Subjects>> editSubjects();
  Future<Map<String, dynamic>> deleteSubjects(
      String accessToken, int idSubjects);
  Future<Map<String, dynamic>> addEditeSubjects(String accessToken, String name,
      int idSubjects, int choolId, String abbreviation, List<int> teachers);
  Future<Map<String, dynamic>> addEditeSubjectsDelete(
      String accessToken,
      String name,
      int idSubjects,
      int choolId,
      String abbreviation,
      List<int> teachers);
}

class SubjectsRepositoryImp extends SubjectsRepository {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<List<Subjects>> getAllSubjects(int schoolId) async {
    List<Subjects> subjectsList;
    final response =
        await _apiProvider.get(Urls.Get_All_Subjects + "?SchoolId=$schoolId");
    print(response);
    Iterable iterable = response['data'];
    subjectsList = iterable.map((model) => Subjects.fromJson(model)).toList();
    return subjectsList;
  }

  @override
  Future<Map<String, dynamic>> deleteSubjects(
      String accessToken, int idSubjects) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results = await _apiProvider
        .get(Urls.Delete_Subject + "?Id=${idSubjects}", header: headers);

    return results;
  }

  @override
  Future<List<Subjects>> editSubjects() {}

  @override
  Future<Map<String, dynamic>> addEditeSubjects(
      String accessToken,
      String materialname,
      int idSubjects,
      int schoolId,
      String abbreviation,
      List<int> teachers) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results = await _apiProvider.post(Urls.Add_Subject,
        body: {
          "id": idSubjects,
          "name": materialname,
          "schoolId": schoolId,
          "abbreviation": abbreviation,
          "teachers": teachers
        },
        header: headers);

    return results;
  }

  @override
  Future<Map<String, dynamic>> addEditeSubjectsDelete(
      String accessToken,
      String materialname,
      int idSubjects,
      int schoolId,
      String abbreviation,
      List<int> teachers) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results = await _apiProvider.post(Urls.Add_Subject,
        body: {
          "id": idSubjects,
          "name": materialname,
          "schoolId": schoolId,
          "abbreviation": abbreviation,
          "teachers": teachers
        },
        header: headers);

    return results;
  }
}
