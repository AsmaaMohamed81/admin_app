import 'package:admin_app/data/model/semester.dart';
import 'package:admin_app/networking/api_provider.dart';
import 'package:admin_app/utils/urls.dart';
import 'package:flutter/cupertino.dart';

abstract class SemesterRepository {
  Future<List<Semester>> getAllSemester(int schoolId);
  Future<List<Semester>> editSemester();
  Future<Map<String, dynamic>> deleteSemester(
      String accessToken, int idSemester);
  Future<Map<String, dynamic>> addEditeSemester(String accessToken, int id,
      String name, int schoolId, int semestersId, bool isCurrentSemester);

  Future<Map<String, dynamic>> addEditeSemesterDelete(
      String accessToken,
      String name,
      int idSemester,
      int choolId,
      String abbreviation,
      List<int> teachers);
}

class SemesterRepositoryImp extends SemesterRepository {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<List<Semester>> getAllSemester(int Id) async {
    List<Semester> SemesterList;
    final response = await _apiProvider.get(Urls.Get_ALL_Semester + "?Id=$Id");
    print(response);
    Iterable iterable = response['data']['semesters'];
    SemesterList = iterable.map((model) => Semester.fromJson(model)).toList();
    return SemesterList;
  }

  @override
  Future<Map<String, dynamic>> deleteSemester(
      String accessToken, int idSemester) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results = await _apiProvider
        .get(Urls.Delete_Semester + "?Id=${idSemester}", header: headers);

    return results;
  }

  @override
  Future<List<Semester>> editSemester() {}

  @override
  Future<Map<String, dynamic>> addEditeSemester(
      String accessToken,
      int id,
      String name,
      int schoolId,
      int semestersId,
      bool isCurrentSemester) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results = await _apiProvider.post(Urls.Add_Semester,
        body: {
          "id": id,
          "name": name,
          "academicYearId": semestersId,
          "schoolId": schoolId,
          "isCurrentSemester": isCurrentSemester,
        },
        header: headers);

    return results;
  }

  @override
  Future<Map<String, dynamic>> addEditeSemesterDelete(
      String accessToken,
      String materialname,
      int idSemester,
      int schoolId,
      String abbreviation,
      List<int> teachers) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    // Map<String, dynamic> results =
    //     await _apiProvider.post(Urls.Save_Semester_Years,
    //         body: {
    //           "id": idSemester,
    //           "name": materialname,
    //           "schoolId": schoolId,
    //           "abbreviation": abbreviation,
    //           "teachers": teachers
    //         },
    //         header: headers);

    // return results;
  }
}
