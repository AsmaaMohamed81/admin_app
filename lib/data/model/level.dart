import 'package:equatable/equatable.dart';

class Levels extends Equatable {
  int id;
  String name;
  int schoolId;

  Levels({this.id, this.name, this.schoolId});

  Levels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    schoolId = json['schoolId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['schoolId'] = this.schoolId;
    return data;
  }

  @override
// TODO: implement props
  List<Object> get props => [id, name, schoolId];
}
