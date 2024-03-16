import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:json_to_list_flutter/Model/post.dart';
import 'package:json_to_list_flutter/View/loading_indicator.dart';
import 'package:json_to_list_flutter/View/post_list.dart';

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
              return const LoadingIndicator();
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
                    child: Text('Photo Gallery',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(child: PostList(posts: posts))
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
}
