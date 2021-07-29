part of 'semester_bloc.dart';

abstract class SemesterEvent extends Equatable {
  const SemesterEvent();

  @override
  List<Object> get props => [];
}

class FetchSemester extends SemesterEvent {
  final int Id;

  FetchSemester(this.Id);
}

class DeletSemester extends SemesterEvent {
  final String access;
  final int id;
  final int schoolId;
  final int academicId;

  DeletSemester(this.access, this.id, this.schoolId, this.academicId);
}

class AddOrEditSemester extends SemesterEvent {
  final String access;

  final int id;
  final String name;

  final int schoolId;

  final int academicId;
  final bool isCurrentSemester;

  AddOrEditSemester(
    this.access,
    this.id,
    this.name,
    this.schoolId,
    this.academicId,
    this.isCurrentSemester,
  );
}

class AddOrEditSemesterEdite extends SemesterEvent {
  final String access;

  final int id;
  final String name;

  final int schoolId;

  final int academicId;
  final bool isCurrentSemester;

  AddOrEditSemesterEdite(this.access, this.id, this.name, this.schoolId,
      this.academicId, this.isCurrentSemester);
}

class AddOrEditSemesterSelect extends SemesterEvent {
  final String access;
  final int id;
  final int schoolId;
  final String materialName;
  final String abberviation;
  final List<int> teachers;

  AddOrEditSemesterSelect(this.access, this.id, this.schoolId,
      this.materialName, this.abberviation, this.teachers);
}

class AddOrEditSemesterDelete extends SemesterEvent {
  final String access;
  final int id;
  final int schoolId;
  final String materialName;
  final String abberviation;
  final List<int> teachers;

  AddOrEditSemesterDelete(this.access, this.id, this.schoolId,
      this.materialName, this.abberviation, this.teachers);
}
