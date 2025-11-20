import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonCubit extends Cubit<bool> {
  ButtonCubit() : super(false);

  void show() => emit(true);
  void hide() => emit(false);
}
