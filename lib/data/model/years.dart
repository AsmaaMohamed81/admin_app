class Years {
  int id;
  String name;
  bool isCurrentYear;
  int schoolId;

  Years({this.id, this.name, this.isCurrentYear, this.schoolId});

  Years.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isCurrentYear = json['isCurrentYear'];
    schoolId = json['schoolId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isCurrentYear'] = this.isCurrentYear;
    data['schoolId'] = this.schoolId;
    return data;
  }
}