import 'package:admin_app/data/model/classes.dart';
import 'package:admin_app/networking/api_provider.dart';
import 'package:admin_app/utils/urls.dart';

abstract class ClassesRepository {
  Future<List<Classes>> getAllClasses(int schoolId);
  Future<Map<String, dynamic>> deleteClasses(String accessToken, int idclass);
  Future<Map<String, dynamic>> addEditeClasses(String accessToken, int id,
      int schoolId, int idClass, int academicYearId, String name);
}

class ClassesRepositoryImp extends ClassesRepository {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<List<Classes>> getAllClasses(int schoolId) async {
    List<Classes> classList;
    final response =
        await _apiProvider.get(Urls.Get_ALL_CLASSES + "?SchoolId=$schoolId");
    print(response);
    Iterable iterable = response['data'];
    classList = iterable.map((model) => Classes.fromJson(model)).toList();
    return classList;
  }

  @override
  Future<Map<String, dynamic>> deleteClasses(
      String accessToken, int classId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results = await _apiProvider
        .get(Urls.Delete_class + "?Id=${classId}", header: headers);

    return results;
  }

  @override
  Future<Map<String, dynamic>> addEditeClasses(String accessToken, int id,
      int schoolId, int idClass, int academicYearId, String name) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };
    Map<String, dynamic> results = await _apiProvider.post(Urls.Add_Class,
        body: {
          "id": id,
          "schoolId": schoolId,
          "levelId": idClass,
          "academicYearId": academicYearId,
          "name": name,
        },
        header: headers);

    return results;
  }
}
