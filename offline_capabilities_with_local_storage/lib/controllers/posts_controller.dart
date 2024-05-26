import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/post_model.dart';

class PostsController extends GetxController {
  var posts = <Post>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        posts.value = data.map((post) => Post.fromJson(post)).toList();
        cachePosts(posts.value);
      } else {
        Get.snackbar('Error', 'Failed to fetch posts');
        loadCachedPosts();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch posts');
      loadCachedPosts();
    } finally {
      isLoading(false);
    }
  }

  void cachePosts(List<Post> posts) {
    var box = Hive.box<Post>('postsBox');
    box.clear();
    box.addAll(posts);
  }

  void loadCachedPosts() {
    var box = Hive.box<Post>('postsBox');
    posts.value = box.values.toList();
  }
}
