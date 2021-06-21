import 'package:admin_app/data/model/subjects.dart';

class ArgumentsTeacherSubjects {
  final List<TeacherToSubjects> teacherToSubjects;
  final Subjects subjects;
  final int value;

  ArgumentsTeacherSubjects(this.teacherToSubjects, this.value, this.subjects);
}
