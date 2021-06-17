part of 'own_school_bloc.dart';

abstract class OwnSchoolEvent extends Equatable {
  const OwnSchoolEvent();

  @override
  List<Object> get props => [];
}

class FetchOwnSchools extends OwnSchoolEvent {
  final String accessToken;

  FetchOwnSchools(this.accessToken);
}
