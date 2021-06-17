class Subjects {
  int id;
  String name;
  String abbreviation;
  int schoolId;
  List<TeacherToSubjects> teacherToSubjects = [];

  Subjects(
      {this.id,
      this.name,
      this.abbreviation,
      this.schoolId,
      this.teacherToSubjects});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    abbreviation = json['abbreviation'];
    schoolId = json['schoolId'];
    if (json['teacherToSubjects'] != null) {
      teacherToSubjects = [];
      json['teacherToSubjects'].forEach((v) {
        teacherToSubjects.add(new TeacherToSubjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['abbreviation'] = this.abbreviation;
    data['schoolId'] = this.schoolId;
    if (this.teacherToSubjects != null) {
      data['teacherToSubjects'] =
          this.teacherToSubjects.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeacherToSubjects {
  int id;
  int subjectId;
  String subjectName;
  int teacherId;
  String teacherName;

  TeacherToSubjects(
      {this.id,
      this.subjectId,
      this.subjectName,
      this.teacherId,
      this.teacherName});

  TeacherToSubjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectId = json['subjectId'];
    subjectName = json['subjectName'];
    teacherId = json['teacherId'];
    teacherName = json['teacherName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subjectId'] = this.subjectId;
    data['subjectName'] = this.subjectName;
    data['teacherId'] = this.teacherId;
    data['teacherName'] = this.teacherName;
    return data;
  }
}
