import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/posts_controller.dart';

class PostsScreen extends StatelessWidget {
  final PostsController postsController = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Obx(() {
        if (postsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: postsController.posts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(postsController.posts[index].title),
                subtitle: Text(postsController.posts[index].body),
              );
            },
          );
        }
      }),
    );
  }
}
