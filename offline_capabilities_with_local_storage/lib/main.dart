import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/posts_screen.dart';
import 'models/post_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Hive.registerAdapter(PostAdapter()); // Register the adapter for Post model
  await Hive.openBox<Post>('postsBox'); // Open the Hive box
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Offline Capabilities with Local Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostsScreen(),
    );
  }
}
