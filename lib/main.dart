import 'package:flutter/material.dart';
import 'package:json_to_list_flutter/Model/post_bloc.dart';
import 'package:json_to_list_flutter/Model/post_event.dart';
import 'package:json_to_list_flutter/Model/post_state.dart';
import 'package:json_to_list_flutter/View/post_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<PostBloc>(
        create: (context) => PostBloc(),
        child: const Scaffold(
          body: PostStatelessPage(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PostStatelessPage extends StatelessWidget {
  const PostStatelessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostInitState) {
        BlocProvider.of<PostBloc>(context).add(const PostInitEvent());
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        );
      }
      if (state is PostLoadedState) {
        //
        return Column(
          children: [
            Container(
                color: const Color.fromARGB(0, 0, 0, 0),
                child: const SizedBox(height: 20, width: double.infinity)),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('Photo Gallery',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Expanded(child: PostList(posts: state.postList))
          ],
        );
        //
      }
      return const Text("..");
    });
  }
}
