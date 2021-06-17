part of 'teachers_bloc.dart';

abstract class TeachersEvent extends Equatable {
  const TeachersEvent();

  @override
  List<Object> get props => [];
}

class FetchTeachers extends TeachersEvent {
  final int schoolId;

  FetchTeachers(this.schoolId);
}

class DeletTeachers extends TeachersEvent {
  final String access;
  final int id;
  final int schoolId;

  DeletTeachers(this.access, this.id, this.schoolId);
}

class AddOrEditTeachers extends TeachersEvent {
  final String access;
  final int id;
  final int schoolId;
  final String name;

  AddOrEditTeachers(this.access, this.id, this.schoolId, this.name);
}
