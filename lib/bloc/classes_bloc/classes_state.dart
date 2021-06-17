part of 'classes_bloc.dart';


abstract class ClassesState extends Equatable {
  const ClassesState();

  @override
  List<Object> get props => [];
}

class ClassesInitial extends ClassesState {}

class ClassesLoading extends ClassesState {}

class ClassesLoaded extends ClassesState {
  final List<Classes> classes;

  ClassesLoaded(this.classes);
}

class ClassesDeleted extends ClassesState {
  final Map<String, dynamic> message;

  ClassesDeleted(this.message);
}

class ClassesAddOrEdite extends ClassesState {
  final Map<String, dynamic> results ;

  ClassesAddOrEdite(this.results);
}

class ClassesError extends ClassesState {
  final String message;

  ClassesError(this.message);
}
