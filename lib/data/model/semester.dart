class Semester {
  int id;
  String name;
  int academicYearId;
  String academicYearName;
  int schoolId;
  bool isCurrentSemester;
  bool isCurrentYear;

  Semester(
      {this.id,
      this.name,
      this.academicYearId,
      this.academicYearName,
      this.schoolId,
      this.isCurrentSemester,
      this.isCurrentYear});

  Semester.fromJson(Map<String, dynamic> json) {
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
