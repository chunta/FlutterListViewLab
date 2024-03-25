import 'package:flutter/material.dart';
import 'package:json_to_list_flutter/Model/post.dart';
import 'package:json_to_list_flutter/View/post_image.dart';

class PostList extends StatelessWidget {
  final List<Post> posts;

  const PostList({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostImage(
          post: posts[index],
          index: index,
        );
      },
    );
  }
}
