import 'package:json_to_list_flutter/Model/post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PostState extends Equatable {}

class PostInitState extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoadingState extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoadedState extends PostState {
  PostLoadedState(this.postList);
  final List<Post> postList;

  @override
  List<Post> get props => postList;
}

class PostErrorState extends PostState {
  PostErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
