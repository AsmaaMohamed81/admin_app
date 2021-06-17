part of 'years_bloc.dart';

abstract class YearsEvent extends Equatable {
  const YearsEvent();

  @override
  List<Object> get props => [];
}

class FetchYears extends YearsEvent {
  final int schoolId;

  FetchYears(this.schoolId);
}

class DeletYears extends YearsEvent {
  final String access;
  final int id;
  final int schoolId;

  DeletYears(this.access, this.id, this.schoolId);
}

class AddOrEditYears extends YearsEvent {
  final String access;
  final int id;
  final int schoolId;
  final int levelId;
  final int yearId;
  final String name;

  AddOrEditYears(this.access, this.id, this.schoolId, this.name, this.levelId, this.yearId);
}
