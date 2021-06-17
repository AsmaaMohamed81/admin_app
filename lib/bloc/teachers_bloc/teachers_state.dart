part of 'teachers_bloc.dart';

abstract class TeachersState extends Equatable {
  const TeachersState();

  @override
  List<Object> get props => [];
}

class TeachersInitial extends TeachersState {}

class TeachersLoading extends TeachersState {}

class TeachersLoaded extends TeachersState {
  final List<Teachers> teachers;

  TeachersLoaded(this.teachers);
}

class TeachersDeleted extends TeachersState {
  final Map<String, dynamic> message;

  TeachersDeleted(this.message);
}

class TeachersAddOrEdite extends TeachersState {
  final Map<String, dynamic> results ;

  TeachersAddOrEdite(this.results);
}

class TeachersError extends TeachersState {
  final String message;

  TeachersError(this.message);
}
