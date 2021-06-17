import 'dart:async';

import 'package:admin_app/data/model/teachers.dart';
import 'package:admin_app/data/repository/teacher.repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'teachers_event.dart';
part 'teachers_state.dart';

class TeachersBloc extends Bloc<TeachersEvent, TeachersState> {
  final TeachersRepository repository;

  TeachersBloc(@required this.repository) : super(TeachersInitial());

  @override
  Stream<TeachersState> mapEventToState(
    TeachersEvent event,
  ) async* {
    if (event is FetchTeachers) {
      yield TeachersLoading();
      try {
        final teachers = await repository.getAllTeachers(event.schoolId);
        yield TeachersLoaded(teachers);
      } catch (e) {
        yield TeachersError(e.toString());
      }
    } else if (event is DeletTeachers) {
      yield TeachersLoading();
      try {
        final isdelete = await repository.deleteTeachers(event.access, event.id);
        yield TeachersDeleted(isdelete);

          final teachers = await repository.getAllTeachers(event.schoolId);
          yield TeachersLoaded(teachers);
        
      } catch (e) {
        yield TeachersError(e.toString());
      }
    } else if (event is AddOrEditTeachers) {
      yield TeachersLoading();
      try {
        final result = await repository.addEditeTeachers(
            event.access, event.name, event.id, event.schoolId);
        yield TeachersAddOrEdite(result);
        
        final teachers = await repository.getAllTeachers(event.schoolId);
        yield TeachersLoaded(teachers);
      } catch (e) {
        yield TeachersError(e.toString());
      }
    }
  }
}

Future sleep1() {
  return new Future.delayed(const Duration(seconds: 5), () => "1");
}
