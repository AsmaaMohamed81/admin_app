import 'dart:async';
import 'package:admin_app/data/repository/Semester_repository.dart';
import 'package:admin_app/data/model/semester.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'semester_event.dart';
part 'semester_state.dart';

class SemesterBloc extends Bloc<SemesterEvent, SemesterState> {
  final SemesterRepository repository;

  SemesterBloc(@required this.repository) : super(SemesterInitial());

  @override
  Stream<SemesterState> mapEventToState(
    SemesterEvent event,
  ) async* {
    if (event is FetchSemester) {
      yield SemesterLoading();
      try {
        final semester = await repository.getAllSemester(event.Id);
        yield SemesterLoaded(semester);
      } catch (e) {
        yield SemesterError(e.toString());
      }
    } else if (event is DeletSemester) {
      yield SemesterLoading();
      try {
        final isdelete =
            await repository.deleteSemester(event.access, event.id);
        yield SemesterDeleted(isdelete);

        final semester = await repository.getAllSemester(event.academicId);
        yield SemesterLoaded(semester);
      } catch (e) {
        yield SemesterError(e.toString());
      }
    } else if (event is AddOrEditSemester) {
      yield SemesterLoading();
      try {
        final result = await repository.addEditeSemester(
            event.access,
            event.id,
            event.name,
            event.schoolId,
            event.academicId,
            event.isCurrentSemester);
        yield SemesterAddOrEdite(result);

        final semester = await repository.getAllSemester(event.academicId);
        yield SemesterLoaded(semester);
      } catch (e) {
        yield SemesterError(e.toString());
      }
    } else if (event is AddOrEditSemesterDelete) {
      yield SemesterLoading();
      try {
        final result = await repository.addEditeSemesterDelete(
            event.access,
            event.materialName,
            event.id,
            event.schoolId,
            event.abberviation,
            event.teachers);
        yield SemesterAddOrEditeDelete(result);

        final semester = await repository.getAllSemester(event.schoolId);
        yield SemesterLoaded(semester);
      } catch (e) {
        yield SemesterError(e.toString());
      }
    } else if (event is AddOrEditSemesterEdite) {
      yield SemesterLoading();
      try {
        final result = await repository.addEditeSemester(
            event.access,
            event.id,
            event.name,
            event.schoolId,
            event.academicId,
            event.isCurrentSemester);
        yield SemesterAddOrEditeEdite(result);
        sleep1();
        final semester = await repository.getAllSemester(event.academicId);
        yield SemesterLoaded(semester);
      } catch (e) {
        yield SemesterError(e.toString());
      }
    } else if (event is AddOrEditSemesterSelect) {
      yield SemesterLoading();
      try {
        final result = await repository.addEditeSemesterDelete(
            event.access,
            event.materialName,
            event.id,
            event.schoolId,
            event.abberviation,
            event.teachers);
        yield SemesterAddOrEditeSelecte(result);

        // final Semester = await repository.getAllSemester(event.schoolId);
        // yield SemesterLoaded(Semester);
      } catch (e) {
        yield SemesterError(e.toString());
      }
    }
  }
}

Future sleep1() {
  return new Future.delayed(const Duration(seconds: 5), () => "1");
}
