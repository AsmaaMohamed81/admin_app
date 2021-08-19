part of 'academic_bloc.dart';

abstract class AcademicState extends Equatable {
  const AcademicState();

  @override
  List<Object> get props => [];
}

class AcademicInitial extends AcademicState {}

class AcademicLoading extends AcademicState {}

class AcademicLoaded extends AcademicState {
  final List<Academic> academic;

  AcademicLoaded(this.academic);
}

class AcademicDeleted extends AcademicState {
  final Map<String, dynamic> message;

  AcademicDeleted(this.message);
}

class AcademicAddOrEdite extends AcademicState {
  final Map<String, dynamic> results;

  AcademicAddOrEdite(this.results);
}

class AcademicEdite extends AcademicState {
  final Map<String, dynamic> results;

  AcademicEdite(this.results);
}

class AcademicAddOrEditeDelete extends AcademicState {
  final Map<String, dynamic> results;

  AcademicAddOrEditeDelete(this.results);
}

class AcademicAddOrEditeEdite extends AcademicState {
  final Map<String, dynamic> results;

  AcademicAddOrEditeEdite(this.results);
}

class AcademicAddOrEditeSelecte extends AcademicState {
  final Map<String, dynamic> results;

  AcademicAddOrEditeSelecte(this.results);
}

class AcademicError extends AcademicState {
  final String message;

  AcademicError(this.message);
}
