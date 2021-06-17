import 'dart:async';

import 'package:admin_app/data/model/level.dart';
import 'package:admin_app/data/repository/level.repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'levels_event.dart';
part 'levels_state.dart';

class LevelsBloc extends Bloc<LevelsEvent, LevelsState> {
  final LevelRepository repository;

  LevelsBloc(@required this.repository) : super(LevelsInitial());

  @override
  Stream<LevelsState> mapEventToState(
    LevelsEvent event,
  ) async* {
    if (event is FetchLevels) {
      yield LevelLoading();
      try {
        final levels = await repository.getAllLevels(event.schoolId);
        yield LevelLoaded(levels);
      } catch (e) {
        yield LevelError(e.toString());
      }
    } else if (event is DeletLevels) {
      yield LevelLoading();
      try {
        final isdelete = await repository.deleteLevels(event.access, event.id);
        yield LevelsDeleted(isdelete);

          final levels = await repository.getAllLevels(event.schoolId);
          yield LevelLoaded(levels);
        
      } catch (e) {
        yield LevelError(e.toString());
      }
    } else if (event is AddOrEditLevels) {
      yield LevelLoading();
      try {
        final result = await repository.addEditeLevels(
            event.access, event.name, event.id, event.schoolId);
        yield LevelsAddOrEdite(result);
        
        final levels = await repository.getAllLevels(event.schoolId);
        yield LevelLoaded(levels);
      } catch (e) {
        yield LevelError(e.toString());
      }
    }
  }
}

Future sleep1() {
  return new Future.delayed(const Duration(seconds: 5), () => "1");
}
