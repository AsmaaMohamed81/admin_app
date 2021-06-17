part of 'levels_bloc.dart';

abstract class LevelsEvent extends Equatable {
  const LevelsEvent();

  @override
  List<Object> get props => [];
}

class FetchLevels extends LevelsEvent {
  final int schoolId;

  FetchLevels(this.schoolId);
}

class DeletLevels extends LevelsEvent {
  final String access;
  final int id;
  final int schoolId;

  DeletLevels(this.access, this.id, this.schoolId);
}

class AddOrEditLevels extends LevelsEvent {
  final String access;
  final int id;
  final int schoolId;
  final String name;

  AddOrEditLevels(this.access, this.id, this.schoolId, this.name);
}
