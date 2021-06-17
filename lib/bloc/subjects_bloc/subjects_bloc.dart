import 'dart:async';

import 'package:admin_app/data/model/subjects.dart';
import 'package:admin_app/data/repository/subjects.repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'subjects_event.dart';
part 'subjects_state.dart';

class SubjectsBloc extends Bloc<SubjectsEvent, SubjectsState> {
  final SubjectsRepository repository;

  SubjectsBloc(@required this.repository) : super(SubjectsInitial());

  @override
  Stream<SubjectsState> mapEventToState(
    SubjectsEvent event,
  ) async* {
    if (event is FetchSubjects) {
      yield SubjectsLoading();
      try {
        final subjects = await repository.getAllSubjects(event.schoolId);
        yield SubjectsLoaded(subjects);
      } catch (e) {
        yield SubjectsError(e.toString());
      }
    } else if (event is DeletSubjects) {
      yield SubjectsLoading();
      try {
        final isdelete =
            await repository.deleteSubjects(event.access, event.id);
        yield SubjectsDeleted(isdelete);

        final subjects = await repository.getAllSubjects(event.schoolId);
        yield SubjectsLoaded(subjects);
      } catch (e) {
        yield SubjectsError(e.toString());
      }
    } else if (event is AddOrEditSubjects) {
      yield SubjectsLoading();
      try {
        final result = await repository.addEditeSubjects(
            event.access,
            event.materialName,
            event.id,
            event.schoolId,
            event.abberviation,
            event.teachers);
        yield SubjectsAddOrEdite(result);

        final subjects = await repository.getAllSubjects(event.schoolId);
        yield SubjectsLoaded(subjects);
      } catch (e) {
        yield SubjectsError(e.toString());
      }
    }
  }
}

Future sleep1() {
  return new Future.delayed(const Duration(seconds: 5), () => "1");
}
