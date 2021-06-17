import 'dart:async';

import 'package:admin_app/data/model/ownschool.dart';
import 'package:admin_app/data/repository/own_schools_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'own_school_event.dart';
part 'own_school_state.dart';

class OwnSchoolBloc extends Bloc<OwnSchoolEvent, OwnSchoolState> {
  final OwnSchoolRepository repository;
  
  OwnSchoolBloc(this.repository) : super(OwnSchoolInitial());

  @override
  Stream<OwnSchoolState> mapEventToState(
    OwnSchoolEvent event,
  ) async* {
    if (event is FetchOwnSchools) {
      yield OwnSchoolLoading();
      try {
        final OwnSchools = await repository.getOwnSchools(event.accessToken);
        yield OwnSchoolLoaded(OwnSchools);
      } catch (e) {
        yield OwnSchoolError(e.toString());
      }
    }
  }
}
