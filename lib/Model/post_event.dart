import 'package:tuple/tuple.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PostEvent extends Equatable {
  const PostEvent();
}

class PostInitEvent extends PostEvent {
  const PostInitEvent();

  @override
  List<Object> get props => [];
}

class PostUpdateEvent extends PostEvent {
  final int updateIndex;
  final bool expanded;
  const PostUpdateEvent({required this.updateIndex, required this.expanded});

  @override
  List<Tuple2<int, bool>> get props =>
      [Tuple2<int, bool>(updateIndex, expanded)];
}
