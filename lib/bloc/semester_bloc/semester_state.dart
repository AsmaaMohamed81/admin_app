part of 'semester_bloc.dart';

abstract class SemesterState extends Equatable {
  const SemesterState();

  @override
  List<Object> get props => [];
}

class SemesterInitial extends SemesterState {}

class SemesterLoading extends SemesterState {}

class SemesterLoaded extends SemesterState {
  final List<Semester> semester;

  SemesterLoaded(this.semester);
}

class SemesterDeleted extends SemesterState {
  final Map<String, dynamic> message;

  SemesterDeleted(this.message);
}

class SemesterAddOrEdite extends SemesterState {
  final Map<String, dynamic> results;

  SemesterAddOrEdite(this.results);
}

class SemesterAddOrEditeDelete extends SemesterState {
  final Map<String, dynamic> results;

  SemesterAddOrEditeDelete(this.results);
}

class SemesterAddOrEditeEdite extends SemesterState {
  final Map<String, dynamic> results;

  SemesterAddOrEditeEdite(this.results);
}

class SemesterAddOrEditeSelecte extends SemesterState {
  final Map<String, dynamic> results;

  SemesterAddOrEditeSelecte(this.results);
}

class SemesterError extends SemesterState {
  final String message;

  SemesterError(this.message);
}
