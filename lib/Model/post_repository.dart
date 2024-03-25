import 'package:json_to_list_flutter/Model/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostRepository {
  Future<List<Post>> getPosts() async {
    var url = Uri.parse(
        "https://dl.dropboxusercontent.com/s/zkvbrf79zuzqvjy/labmocklist.json");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    Map<String, dynamic> jsonMap = json.decode(response.body);
    String contentString = json.encode(jsonMap['content']);
    final List body = json.decode(contentString);
    return body.map((e) => Post.fromJson(e)).toList();
  }
}
