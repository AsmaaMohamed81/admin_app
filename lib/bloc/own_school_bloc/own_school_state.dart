part of 'own_school_bloc.dart';

abstract class OwnSchoolState extends Equatable {
  const OwnSchoolState();
  
  @override
  List<Object> get props => [];
}

class OwnSchoolInitial extends OwnSchoolState {}


class OwnSchoolLoading extends OwnSchoolState {}

class OwnSchoolLoaded extends OwnSchoolState {
  final List<OwnSchool> ownSchool;

  OwnSchoolLoaded(this.ownSchool);
}


class OwnSchoolError extends OwnSchoolState {
  final String message;

  OwnSchoolError(this.message);
}