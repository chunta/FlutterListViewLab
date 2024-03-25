import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_to_list_flutter/Model/post.dart';
import 'package:json_to_list_flutter/Model/post_event.dart';
import 'package:json_to_list_flutter/Model/post_repository.dart';
import 'package:json_to_list_flutter/Model/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository = PostRepository();
  late List<Post> postCache;
  PostBloc() : super(PostInitState()) {
    on<PostInitEvent>(_onInit);
    on<PostUpdateEvent>(_onUpdate);
  }

  void _onInit(PostInitEvent event, Emitter<PostState> emit) async {
    postCache = await repository.getPosts();
    emit(PostLoadedState(postCache));
  }

  void _onUpdate(PostUpdateEvent event, Emitter<PostState> emit) {
    postCache[event.updateIndex].expanded = event.expanded;
    emit(PostLoadedState(postCache));
  }
}
