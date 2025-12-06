import 'package:blog_app/core/common/widgets/basic_app_bar_widget.dart';
import 'package:blog_app/core/helper/app_navigator.dart';
import 'package:blog_app/features/blog/presentation/pages/add_blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: true,
        action: IconButton(
          onPressed: () {
            AppNavigator.push(context, AddBlogScreen());
          },
          icon: Icon(Icons.add_circle_outline),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Supabase.instance.client.auth.signOut();
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
