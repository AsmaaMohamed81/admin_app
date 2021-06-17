part of 'years_bloc.dart';

abstract class YearsState extends Equatable {
  const YearsState();

  @override
  List<Object> get props => [];
}

class YearsInitial extends YearsState {}

class YearsLoading extends YearsState {}

class YearsLoaded extends YearsState {
  final List<Years> years;

  YearsLoaded(this.years);
}

class YearsDeleted extends YearsState {
  final Map<String, dynamic> message;

  YearsDeleted(this.message);
}

class YearsAddOrEdite extends YearsState {
  final Map<String, dynamic> results ;

  YearsAddOrEdite(this.results);
}

class YearsError extends YearsState {
  final String message;

  YearsError(this.message);
}
