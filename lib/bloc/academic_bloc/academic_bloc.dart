import 'dart:async';
import 'dart:math';

import 'package:admin_app/data/model/academic.dart';
import 'package:admin_app/data/repository/academic_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'academic_event.dart';
part 'academic_state.dart';

class AcademicBloc extends Bloc<AcademicEvent, AcademicState> {
  final AcademicRepository repository;

  AcademicBloc(@required this.repository) : super(AcademicInitial());

  @override
  Stream<AcademicState> mapEventToState(
    AcademicEvent event,
  ) async* {
    if (event is FetchAcademic) {
      yield AcademicLoading();
      try {
        final Academic = await repository.getAllAcademic(event.schoolId);
        yield AcademicLoaded(Academic);
      } catch (e) {
        yield AcademicError(e.toString());
      }
    } else if (event is DeletAcademic) {
      yield AcademicLoading();
      try {
        final isdelete =
            await repository.deleteAcademic(event.access, event.id);
        yield AcademicDeleted(isdelete);

        final Academic = await repository.getAllAcademic(event.schoolId);
        yield AcademicLoaded(Academic);
      } catch (e) {
        yield AcademicError(e.toString());
      }
    } else if (event is AddOrEditAcademic) {
      yield AcademicLoading();
      try {
        final result = await repository.addEditeAcademic(
            event.access,
            event.id,
            event.name,
            event.isCurrentYear,
            event.schoolId,
            event.semestersId,
            event.semestersName,
            event.isCurrentSemester);
        yield AcademicAddOrEdite(result);

        final Academic = await repository.getAllAcademic(event.schoolId);
        yield AcademicLoaded(Academic);
      } catch (e) {
        yield AcademicError(e.toString());
      }
    } else if (event is AddOrEditAcademicDelete) {
      yield AcademicLoading();
      try {
        final result = await repository.addEditeAcademicDelete(
            event.access,
            event.materialName,
            event.id,
            event.schoolId,
            event.abberviation,
            event.teachers);
        yield AcademicAddOrEditeDelete(result);

        final Academic = await repository.getAllAcademic(event.schoolId);
        yield AcademicLoaded(Academic);
      } catch (e) {
        yield AcademicError(e.toString());
      }
    } else if (event is AddOrEditAcademicEdite) {
      yield AcademicLoading();
      try {
        final result = await repository.addEditeAcademicDelete(
            event.access,
            event.materialName,
            event.id,
            event.schoolId,
            event.abberviation,
            event.teachers);
        yield AcademicAddOrEditeEdite(result);

        final Academic = await repository.getAllAcademic(event.schoolId);
        yield AcademicLoaded(Academic);
      } catch (e) {
        yield AcademicError(e.toString());
      }
    } else if (event is AddOrEditAcademicSelect) {
      yield AcademicLoading();
      try {
        final result = await repository.addEditeAcademicDelete(
            event.access,
            event.materialName,
            event.id,
            event.schoolId,
            event.abberviation,
            event.teachers);
        yield AcademicAddOrEditeSelecte(result);

        // final Academic = await repository.getAllAcademic(event.schoolId);
        // yield AcademicLoaded(Academic);
      } catch (e) {
        yield AcademicError(e.toString());
      }
    }
  }
}

Future sleep1() {
  return new Future.delayed(const Duration(seconds: 5), () => "1");
}
