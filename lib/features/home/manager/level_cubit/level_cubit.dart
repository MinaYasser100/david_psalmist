import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'level_state.dart';

class LevelCubit extends Cubit<LevelState> {
  LevelCubit() : super(LevelInitial());
}
