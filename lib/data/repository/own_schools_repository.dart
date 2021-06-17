import 'package:admin_app/data/model/ownschool.dart';
import 'package:admin_app/networking/api_provider.dart';
import 'package:admin_app/utils/urls.dart';

abstract class OwnSchoolRepository {
  Future<List<OwnSchool>> getOwnSchools(String accessToken);
}

class schoolsRepositoryImp extends OwnSchoolRepository {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<List<OwnSchool>> getOwnSchools(String accessToken) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${accessToken}"
    };

    List<OwnSchool> ownSchool;
    final response =
        await _apiProvider.get(Urls.Get_All_Schools, header: headers);
    print(response);
    Iterable iterable = response['data']['ownSchools'];
    ownSchool = iterable.map((model) => OwnSchool.fromJson(model)).toList();
    return ownSchool;
  }
}
