import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_to_list_flutter/Model/post.dart';
import 'package:json_to_list_flutter/Model/post_bloc.dart';
import 'package:json_to_list_flutter/Model/post_event.dart';
import 'package:json_to_list_flutter/View/expandable_text.dart';
import 'loading_indicator.dart';

class PostImage extends StatelessWidget {
  final Post post;
  final int index;
  const PostImage({Key? key, required this.post, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImageDimensions(post.imageurl!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final Size imageSize = snapshot.data as Size;
          return Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  post.title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                AspectRatio(
                  aspectRatio: imageSize.width / imageSize.height,
                  child: Image.network(
                    post.imageurl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ExpandableText(
                  text: post.description!,
                  maxLines: 2,
                  expanded: post.expanded,
                  onExpand: () {
                    BlocProvider.of<PostBloc>(context).add(
                        PostUpdateEvent(updateIndex: index, expanded: true));
                  },
                ),
              ],
            ),
          );
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }

  Future<Size> getImageDimensions(String imageUrl) async {
    final Image image = Image.network(imageUrl);
    final Completer<Size> completer = Completer<Size>();
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          completer.complete(Size(
            info.image.width.toDouble(),
            info.image.height.toDouble(),
          ));
        },
      ),
    );
    return completer.future;
  }
}
