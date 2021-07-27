class Urls {
  static const int ID_SCHOOL = 53;
  static const String BASE_URL =
      "https://talentnotionapi.azurewebsites.net/api";

/////////LOGIN
  static const String LOGIN_URL = BASE_URL + "/Account/Login";
  static const String REGISTER_URL = BASE_URL + "/Account/Register";

////////// Schools
  static const String Get_All_Schools =
      BASE_URL + "/Orgnization/GetAllOrgnizationsHaveRolesInIt";

////////// level
  static const String Get_All_Levels =
      BASE_URL + "/SchoolApi/Levels/GetAllLevels";
  static const String Add_Level = BASE_URL + "/SchoolApi/Levels/SaveLevel";
  static const String Delete_Level = BASE_URL + "/SchoolApi/Levels/DeleteLevel";

///////////// Subject
  static const String Get_All_Subjects =
      BASE_URL + "/SchoolApi/Subjects/GetAllSubjects";
  static const String Add_Subject =
      BASE_URL + "/SchoolApi/Subjects/SaveSubject";
  static const String Delete_Subject =
      BASE_URL + "/SchoolApi/Subjects/DeleteSubject";

////////AcademicYears
  static const String Get_All_AcademicYears =
      BASE_URL + "/SchoolApi/AcademicYears/GetAcademicYearHasSemesters";

  ////////////Classes
  static const String Get_ALL_CLASSES =
      BASE_URL + "/SchoolApi/Classes/GetAllClassesNoPaging";
  static const String Add_Class = BASE_URL + "/SchoolApi/Classes/SaveClass";
  static const String Delete_class =
      BASE_URL + "/SchoolApi/Classes/DeleteClass";

////////////////Teacher //////////////
  static const String GET_ALL_TEACHERS =
      BASE_URL + "/SchoolApi/Teacher/GetAllTeachers";

/////////////////////////////////
  static const String ADD_TEACHER_TO_ACHOOL =
      BASE_URL + "/SchoolApi/Teacher/AddUserAsMemberSchool";
  static const String DELETE_TEACHER =
      BASE_URL + "/SchoolApi/Teacher/DeleteMember";
  static const String GET_MATERIALS =
      BASE_URL + "/SchoolApi/Materials/GetAllMaterials";
  static const String ADD_TEACHER_TO_Material =
      BASE_URL + "/SchoolApi/Teacher/AddTeacherTomaterial";
  static const String ADD_New_Material =
      BASE_URL + "/SchoolApi/Materials/SaveMaterial";
  static const String DELETE_MATERIAL =
      BASE_URL + "/SchoolApi/Materials/DeleteMaterial";
  static const String GET_MATERIAL_BY_CLASS =
      BASE_URL + "/SchoolApi/SchoolCourse/GetAllCoursesByClassId";
  static const String DELETE_CLASS =
      BASE_URL + "/SchoolApi/EducationClasses/DeleteClass";
  static const String ADD_New_CLASS =
      BASE_URL + "/SchoolApi/EducationClasses/SaveClass";
}
