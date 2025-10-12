import 'package:david_psalmist/core/model/attendance_model/attendance_model.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/attendance/data/repo/attendance_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit(this._attendanceRepo) : super(AttendanceInitial());

  final AttendanceRepo _attendanceRepo;
  List<AttendanceModel> attendanceRecords = <AttendanceModel>[];

  void fetchAttendanceRecords({required StudentModel studentModel}) async {
    emit(AttendanceLoading());
    try {
      final stream = _attendanceRepo.getAttendanceStream(studentModel);
      stream.listen((either) {
        either.fold((failure) => emit(AttendanceError(error: failure)), (
          records,
        ) {
          attendanceRecords = records;
          emit(AttendanceLoaded(attendanceRecords: records));
        });
      });
    } catch (e) {
      emit(AttendanceError(error: "Error fetching attendance records".tr()));
    }
  }
}
