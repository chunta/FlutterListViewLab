import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:json_to_list_flutter/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Post>> postsFuture = getPosts();

  static Future<List<Post>> getPosts() async {
    var url = Uri.parse(
        "https://dl.dropboxusercontent.com/s/zkvbrf79zuzqvjy/labmocklist.json");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    Map<String, dynamic> jsonMap = json.decode(response.body);
    String contentString = json.encode(jsonMap['content']);
    final List body = json.decode(contentString);
    return body.map((e) => Post.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final posts = snapshot.data!;
              return Column(
                children: [
                  Container(
                      color: const Color.fromARGB(0, 0, 0, 0),
                      child:
                          const SizedBox(height: 20, width: double.infinity)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Your Title Here',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(child: buildPosts(posts)),
                  Container(
                      color: const Color.fromARGB(0, 0, 0, 0),
                      child:
                          const SizedBox(height: 60, width: double.infinity)),
                ],
              );
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Widget buildPosts(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Column(
          children: [
            Container(
              color: const Color.fromARGB(0, 0, 0, 0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9, // 替換為實際的寬高比
                      child: Image.network(post.imageurl!),
                    ),
                    const SizedBox(width: 10),
                    Text(post.title!),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
