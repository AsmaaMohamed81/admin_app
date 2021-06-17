import 'dart:async';

import 'package:admin_app/data/model/classes.dart';
import 'package:admin_app/data/repository/classes.repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'classes_event.dart';
part 'classes_state.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  final ClassesRepository repository;

  ClassesBloc(@required this.repository) : super(ClassesInitial());

  @override
  Stream<ClassesState> mapEventToState(
    ClassesEvent event,
  ) async* {
    if (event is FetchClasses) {
      yield ClassesLoading();
      try {
        final classes = await repository.getAllClasses(event.schoolId);
        yield ClassesLoaded(classes);
      } catch (e) {
        yield ClassesError(e.toString());
      }
    } else if (event is DeletClasses) {
      yield ClassesLoading();
      try {
        final isdelete = await repository.deleteClasses(event.access, event.id);
        yield ClassesDeleted(isdelete);

        final classes = await repository.getAllClasses(event.schoolId);
        yield ClassesLoaded(classes);
      } catch (e) {
        yield ClassesError(e.toString());
      }
    } else if (event is AddOrEditClasses) {
      yield ClassesLoading();
      try {
        final result = await repository.addEditeClasses(event.access, event.id,
            event.schoolId, event.classId, event.yearId, event.name);
        yield ClassesAddOrEdite(result);

        final classes = await repository.getAllClasses(event.schoolId);
        yield ClassesLoaded(classes);
      } catch (e) {
        yield ClassesError(e.toString());
      }
    }
  }
}

Future sleep1() {
  return new Future.delayed(const Duration(seconds: 5), () => "1");
}
