import 'dart:io';

import 'package:blog_app/core/functions/pick_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerCubit extends Cubit<File> {
  ImagePickerCubit() : super(File(''));

  File image = File('');
  void imagePick() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      image = pickedImage;
      emit(image);
    }
  }
}
