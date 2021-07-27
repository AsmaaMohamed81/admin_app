import 'package:admin_app/data/model/semester.dart';

class Academic {
  int id;
  String name;
  bool isCurrentYear;
  int schoolId;
  List<Semester> semesters;

  Academic(
      {this.id, this.name, this.isCurrentYear, this.schoolId, this.semesters});

  Academic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isCurrentYear = json['isCurrentYear'];
    schoolId = json['schoolId'];
    if (json['semesters'] != null) {
      semesters = new List<Semester>();
      json['semesters'].forEach((v) {
        semesters.add(new Semester.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isCurrentYear'] = this.isCurrentYear;
    data['schoolId'] = this.schoolId;
    if (this.semesters != null) {
      data['semesters'] = this.semesters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
