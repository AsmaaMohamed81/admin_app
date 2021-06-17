import 'dart:async';
import 'package:admin_app/data/model/level.dart';
import 'package:admin_app/data/model/years.dart';
import 'package:admin_app/data/model/years.dart';
import 'package:admin_app/data/repository/years.repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'years_event.dart';
part 'years_state.dart';

class YearsBloc extends Bloc<YearsEvent, YearsState> {
  final YearsRepository repository;

  YearsBloc(@required this.repository) : super(YearsInitial());

  @override
  Stream<YearsState> mapEventToState(
    YearsEvent event,
  ) async* {
    if (event is FetchYears) {
      yield YearsLoading();
      try {
        final years = await repository.getAllYears(event.schoolId);
        yield YearsLoaded(years);
      } catch (e) {
        yield YearsError(e.toString());
      }
    } else if (event is DeletYears) {
      yield YearsLoading();
      try {
        final isdelete = await repository.deleteYears(event.access, event.id);
        yield YearsDeleted(isdelete);

        final years = await repository.getAllYears(event.schoolId);
        yield YearsLoaded(years);
      } catch (e) {
        yield YearsError(e.toString());
      }
    } else if (event is AddOrEditYears) {
      yield YearsLoading();
      try {
        final result = await repository.addEditeYears(event.access, event.id,
            event.schoolId, event.levelId, event.yearId, event.name);
        yield YearsAddOrEdite(result);

        final years = await repository.getAllYears(event.schoolId);
        yield YearsLoaded(years);
      } catch (e) {
        yield YearsError(e.toString());
      }
    }
  }
}

Future sleep1() {
  return new Future.delayed(const Duration(seconds: 5), () => "1");
}
