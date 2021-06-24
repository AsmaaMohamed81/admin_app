class Teachers {
  int id;
  int userId;
  String userName;
  bool isAccountActivated;
  String status;
  String email;
  String userPhoto;
  int companyId;
  String companyName;
  String companyPhoto;
  String acceptanceStatus;
  bool isClassRoomTeacher;
  String updateDate;
  List<Materials> materials;

  Teachers(
      {this.id,
      this.userId,
      this.userName,
      this.isAccountActivated,
      this.status,
      this.email,
      this.userPhoto,
      this.companyId,
      this.companyName,
      this.companyPhoto,
      this.acceptanceStatus,
      this.isClassRoomTeacher=true,
      this.updateDate,
      this.materials});

  Teachers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userName = json['userName'];
    isAccountActivated = json['isAccountActivated'];
    status = json['status'];
    email = json['email'];
    userPhoto = json['userPhoto'];
    companyId = json['companyId'];
    companyName = json['companyName'];
    companyPhoto = json['companyPhoto'];
    acceptanceStatus = json['acceptanceStatus'];
    isClassRoomTeacher = json['isClassRoomTeacher'];
    updateDate = json['updateDate'];
    if (json['materials'] != null) {
      materials = new List<Materials>();
      json['materials'].forEach((v) {
        materials.add(new Materials.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['isAccountActivated'] = this.isAccountActivated;
    data['status'] = this.status;
    data['email'] = this.email;
    data['userPhoto'] = this.userPhoto;
    data['companyId'] = this.companyId;
    data['companyName'] = this.companyName;
    data['companyPhoto'] = this.companyPhoto;
    data['acceptanceStatus'] = this.acceptanceStatus;
    data['isClassRoomTeacher'] = this.isClassRoomTeacher;
    data['updateDate'] = this.updateDate;
    if (this.materials != null) {
      data['materials'] = this.materials.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Materials {
  int id;
  int teacherId;
  String teacherName;
  int academicYearId;
  String academicYearName;
  int organizationId;
  int levelId;
  String levelName;
  int semesterId;
  String semesterName;
  int subjectId;
  String subjectName;

  Materials(
      {this.id,
      this.teacherId,
      this.teacherName,
      this.academicYearId,
      this.academicYearName,
      this.organizationId,
      this.levelId,
      this.levelName,
      this.semesterId,
      this.semesterName,
      this.subjectId,
      this.subjectName});

  Materials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacherId'];
    teacherName = json['teacherName'];
    academicYearId = json['academicYearId'];
    academicYearName = json['academicYearName'];
    organizationId = json['organizationId'];
    levelId = json['levelId'];
    levelName = json['levelName'];
    semesterId = json['semesterId'];
    semesterName = json['semesterName'];
    subjectId = json['subjectId'];
    subjectName = json['subjectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['teacherId'] = this.teacherId;
    data['teacherName'] = this.teacherName;
    data['academicYearId'] = this.academicYearId;
    data['academicYearName'] = this.academicYearName;
    data['organizationId'] = this.organizationId;
    data['levelId'] = this.levelId;
    data['levelName'] = this.levelName;
    data['semesterId'] = this.semesterId;
    data['semesterName'] = this.semesterName;
    data['subjectId'] = this.subjectId;
    data['subjectName'] = this.subjectName;
    return data;
  }
}
