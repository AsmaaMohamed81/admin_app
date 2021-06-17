part of 'classes_bloc.dart';

abstract class ClassesEvent extends Equatable {
  const ClassesEvent();

  @override
  List<Object> get props => [];
}

class FetchClasses extends ClassesEvent {
  final int schoolId;

  FetchClasses(this.schoolId);
}

class DeletClasses extends ClassesEvent {
  final String access;
  final int id;
  final int schoolId;

  DeletClasses(this.access, this.id, this.schoolId);
}

class AddOrEditClasses extends ClassesEvent {
    final String access;
  final int id;
  final int schoolId;
  final int classId;
  final int yearId;
  final String name;

  AddOrEditClasses(this.access, this.id, this.schoolId, this.name, this.classId, this.yearId);
}
