part of 'subjects_bloc.dart';

abstract class SubjectsEvent extends Equatable {
  const SubjectsEvent();

  @override
  List<Object> get props => [];
}

class FetchSubjects extends SubjectsEvent {
  final int schoolId;

  FetchSubjects(this.schoolId);
}

class DeletSubjects extends SubjectsEvent {
  final String access;
  final int id;
  final int schoolId;

  DeletSubjects(this.access, this.id, this.schoolId);
}

class AddOrEditSubjects extends SubjectsEvent {
  final String access;
  final int id;
  final int schoolId;
  final String materialName;
  final String abberviation;
  final List<int> teachers;

  AddOrEditSubjects(this.access, this.id, this.schoolId, this.materialName,
      this.abberviation, this.teachers);
}

class AddOrEditSubjectsDelete extends SubjectsEvent {
  final String access;
  final int id;
  final int schoolId;
  final String materialName;
  final String abberviation;
  final List<int> teachers;

  AddOrEditSubjectsDelete(this.access, this.id, this.schoolId, this.materialName,
      this.abberviation, this.teachers);
}
