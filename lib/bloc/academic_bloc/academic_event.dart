part of 'academic_bloc.dart';

abstract class AcademicEvent extends Equatable {
  const AcademicEvent();

  @override
  List<Object> get props => [];
}

class FetchAcademic extends AcademicEvent {
  final int schoolId;

  FetchAcademic(this.schoolId);
}

class DeletAcademic extends AcademicEvent {
  final String access;
  final int id;
  final int schoolId;

  DeletAcademic(this.access, this.id, this.schoolId);
}

class AddOrEditAcademic extends AcademicEvent {
  final String access;

  final int id;
  final String name;
  final bool isCurrentYear;

  final int schoolId;

  final List<int> semestersId;
  final List<String> semestersName;
  final List<bool> isCurrentSemester;

  AddOrEditAcademic(
    this.access,
    this.id,
    this.name,
    this.isCurrentYear,
    this.schoolId,
    this.semestersId,
    this.semestersName,
    this.isCurrentSemester,
  );
}

class EditAcademic extends AcademicEvent {
  final String access;

  final int id;
  final String name;
  final bool isCurrentYear;

  final int schoolId;
  final int currentSemetserId;

  EditAcademic(this.access, this.id, this.name, this.isCurrentYear,
      this.currentSemetserId, this.schoolId);
}

class AddOrEditAcademicEdite extends AcademicEvent {
  final String access;
  final int id;
  final int schoolId;
  final String materialName;
  final String abberviation;
  final List<int> teachers;

  AddOrEditAcademicEdite(this.access, this.id, this.schoolId, this.materialName,
      this.abberviation, this.teachers);
}

class AddOrEditAcademicSelect extends AcademicEvent {
  final String access;
  final int id;
  final int schoolId;
  final String materialName;
  final String abberviation;
  final List<int> teachers;

  AddOrEditAcademicSelect(this.access, this.id, this.schoolId,
      this.materialName, this.abberviation, this.teachers);
}

class AddOrEditAcademicDelete extends AcademicEvent {
  final String access;
  final int id;
  final int schoolId;
  final String materialName;
  final String abberviation;
  final List<int> teachers;

  AddOrEditAcademicDelete(this.access, this.id, this.schoolId,
      this.materialName, this.abberviation, this.teachers);
}
