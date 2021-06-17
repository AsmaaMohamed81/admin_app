part of 'subjects_bloc.dart';


abstract class SubjectsState extends Equatable {
  const SubjectsState();

  @override
  List<Object> get props => [];
}

class SubjectsInitial extends SubjectsState {}

class SubjectsLoading extends SubjectsState {}

class SubjectsLoaded extends SubjectsState {
  final List<Subjects> subjects;

  SubjectsLoaded(this.subjects);
}

class SubjectsDeleted extends SubjectsState {
  final Map<String, dynamic> message;

  SubjectsDeleted(this.message);
}

class SubjectsAddOrEdite extends SubjectsState {
  final Map<String, dynamic> results;

  SubjectsAddOrEdite(this.results);
}

class SubjectsError extends SubjectsState {
  final String message;

  SubjectsError(this.message);
}
