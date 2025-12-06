import 'dart:io';

import 'package:blog_app/core/common/widgets/basic_app_bar_widget.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/features/blog/presentation/bloc/image_picker_bloc/image_picker_cubit.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  List<String> selectedTopics = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        action: IconButton(
          onPressed: () {},
          icon: Icon(Icons.check_circle_outline_outlined),
        ),
      ),
      body: BlocProvider(
        create: (BuildContext context) => ImagePickerCubit(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 15.0,
            children: [
              BlocBuilder<ImagePickerCubit, File>(
                builder: (context, state) {
                  return state.path.isNotEmpty
                      ? GestureDetector(
                          onTap: () =>
                              context.read<ImagePickerCubit>().imagePick(),
                          child: SizedBox(
                            height: 150.0,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.file(state, fit: BoxFit.cover),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            print('sss');
                            context.read<ImagePickerCubit>().imagePick();
                            // selectImage();
                          },
                          child: DottedBorder(
                            options: RoundedRectDottedBorderOptions(
                              color: AppColors.borderColor,
                              dashPattern: [10, 4],
                              radius: Radius.circular(15.0),
                            ),
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.folder_open, size: 40),
                                  SizedBox(height: 15),
                                  Text(
                                    'Select your image',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                },
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: Constants.topics
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              if (selectedTopics.contains(e)) {
                                selectedTopics.remove(e);
                              } else {
                                selectedTopics.add(e);
                              }
                              setState(() {});
                            },
                            child: Chip(
                              label: Text(e),
                              color: selectedTopics.contains(e)
                                  ? const WidgetStatePropertyAll(
                                      AppColors.gradient1,
                                    )
                                  : null,
                              side: selectedTopics.contains(e)
                                  ? null
                                  : const BorderSide(
                                      color: AppColors.borderColor,
                                    ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              BlogEditorWidget(
                controller: titleController,
                hintText: 'Blog Title',
              ),
              BlogEditorWidget(
                controller: contentController,
                hintText: 'Blog Content',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
