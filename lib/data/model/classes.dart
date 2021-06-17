class Classes {
  int id;
  String name;
  int levelId;
  String levelName;
  int academicYearId;
  String academicYearName;
  int schoolId;

  Classes(
      {this.id,
      this.name,
      this.levelId,
      this.levelName,
      this.academicYearId,
      this.academicYearName,
      this.schoolId});

  Classes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    levelId = json['levelId'];
    levelName = json['levelName'];
    academicYearId = json['academicYearId'];
    academicYearName = json['academicYearName'];
    schoolId = json['schoolId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['levelId'] = this.levelId;
    data['levelName'] = this.levelName;
    data['academicYearId'] = this.academicYearId;
    data['academicYearName'] = this.academicYearName;
    data['schoolId'] = this.schoolId;
    return data;
  }
}