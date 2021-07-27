class Academic {
  int id;
  String name;
  bool isCurrentYear;
  int schoolId;
  List<Semesters> semesters;

  Academic(
      {this.id, this.name, this.isCurrentYear, this.schoolId, this.semesters});

  Academic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isCurrentYear = json['isCurrentYear'];
    schoolId = json['schoolId'];
    if (json['semesters'] != null) {
      semesters = new List<Semesters>();
      json['semesters'].forEach((v) {
        semesters.add(new Semesters.fromJson(v));
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

class Semesters {
  int id;
  String name;
  int academicYearId;
  String academicYearName;
  int schoolId;
  bool isCurrentSemester;
  bool isCurrentYear;

  Semesters(
      {this.id,
      this.name,
      this.academicYearId,
      this.academicYearName,
      this.schoolId,
      this.isCurrentSemester,
      this.isCurrentYear});

  Semesters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    academicYearId = json['academicYearId'];
    academicYearName = json['academicYearName'];
    schoolId = json['schoolId'];
    isCurrentSemester = json['isCurrentSemester'];
    isCurrentYear = json['isCurrentYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['academicYearId'] = this.academicYearId;
    data['academicYearName'] = this.academicYearName;
    data['schoolId'] = this.schoolId;
    data['isCurrentSemester'] = this.isCurrentSemester;
    data['isCurrentYear'] = this.isCurrentYear;
    return data;
  }
}
