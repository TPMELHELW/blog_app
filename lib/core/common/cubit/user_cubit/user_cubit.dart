import 'package:blog_app/core/common/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void updateUser(User? user) {
    if (user == null) {
      // print('Failure');

      emit(UserInitial());
    } else {
      // print('Success's);
      emit(UserLoggedIn(user: user));
    }
  }
}
