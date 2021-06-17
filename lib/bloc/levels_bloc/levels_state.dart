part of 'levels_bloc.dart';

abstract class LevelsState extends Equatable {
  const LevelsState();

  @override
  List<Object> get props => [];
}

class LevelsInitial extends LevelsState {}

class LevelLoading extends LevelsState {}

class LevelLoaded extends LevelsState {
  final List<Levels> levels;

  LevelLoaded(this.levels);
}

class LevelsDeleted extends LevelsState {
  final Map<String, dynamic> message;

  LevelsDeleted(this.message);
}

class LevelsAddOrEdite extends LevelsState {
  final Map<String, dynamic> results ;

  LevelsAddOrEdite(this.results);
}

class LevelError extends LevelsState {
  final String message;

  LevelError(this.message);
}
