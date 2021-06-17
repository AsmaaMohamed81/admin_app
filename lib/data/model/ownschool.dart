class OwnSchool {
  int id;
  String name;
  String aboutUs;
  String photopath;
  int orgazationType;
  bool isActivated;
  int calenderId;
  String dailySchoolScheduleOption;
  double durationLecture;
  bool isVerifyed;

  OwnSchool(
      {this.id,
      this.name,
      this.aboutUs,
      this.photopath,
      this.orgazationType,
      this.isActivated,
      this.calenderId,
      this.dailySchoolScheduleOption,
      this.durationLecture,
      this.isVerifyed});

  OwnSchool.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    aboutUs = json['aboutUs'];
    photopath = json['photopath'];
    orgazationType = json['orgazationType'];
    isActivated = json['isActivated'];
    calenderId = json['calenderId'];
    dailySchoolScheduleOption = json['dailySchoolScheduleOption'];
    durationLecture = json['durationLecture'];
    isVerifyed = json['isVerifyed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['aboutUs'] = this.aboutUs;
    data['photopath'] = this.photopath;
    data['orgazationType'] = this.orgazationType;
    data['isActivated'] = this.isActivated;
    data['calenderId'] = this.calenderId;
    data['dailySchoolScheduleOption'] = this.dailySchoolScheduleOption;
    data['durationLecture'] = this.durationLecture;
    data['isVerifyed'] = this.isVerifyed;
    return data;
  }
}
