import 'package:admin_app/data/model/teachers.dart';
import 'package:admin_app/networking/api_provider.dart';
import 'package:admin_app/utils/urls.dart';

abstract class TeachersRepository {
  Future<List<Teachers>> getAllTeachers(int schoolId);
  Future<List<Teachers>> editTeachers();
  Future<Map<String, dynamic>> deleteTeachers(
      String accessToken, int idTeacher);
  Future<Map<String, dynamic>> addEditeTeachers(
      String accessToken, String name, int idTeacher, int choolId);
}

class TeachersRepositoryImp extends TeachersRepository {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<List<Teachers>> getAllTeachers(int schoolId) async {
    List<Teachers> teacherList;
    final response =
        await _apiProvider.get(Urls.GET_ALL_TEACHERS + "?SchoolId=$schoolId");
    print(Urls.GET_ALL_TEACHERS + "?SchoolId=$schoolId");
    print("kjkkjhkj$response");
    Iterable iterable = response['data'];
    teacherList = iterable.map((model) => Teachers.fromJson(model)).toList();
    return teacherList;
  }

  @override
  Future<Map<String, dynamic>> deleteTeachers(
      String accessToken, int idteacher) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results = await _apiProvider
        .get(Urls.Delete_Level + "?Id=${idteacher}", header: headers);

    return results;
  }

  @override
  Future<List<Teachers>> editTeachers() {}

  @override
  Future<Map<String, dynamic>> addEditeTeachers(
      String accessToken, String name, int idTeacher, int schoolId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results = await _apiProvider.post(Urls.Add_Level,
        body: {
          "id": idTeacher,
          "name": name,
          "schoolId": schoolId,
        },
        header: headers);

    return results;
  }
}
