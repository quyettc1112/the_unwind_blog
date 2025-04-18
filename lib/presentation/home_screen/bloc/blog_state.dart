import 'package:equatable/equatable.dart';

import '../../../data/models/blog_unwind_model.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object?> get props => [];
}

class BlogInitial extends BlogState {
  @override
  List<Object> get props => [];
}

class BlogLoadingState extends BlogState {
  BlogLoadingState();
}

class BlogLoadedState extends BlogState {
  BlogLoadedState(this.blogs);
  final List<BlogUnwindModel> blogs;
  @override
  List<Object?> get props => blogs.map((blog) => blog.id).toList();
}

class BlogErrorState extends BlogState {
  BlogErrorState(this.message);
  String message;
  @override
  List<Object?> get props => [message];
}