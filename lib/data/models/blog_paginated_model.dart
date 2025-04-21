import '../../domain/entities/blog_unwind_entity.dart';
import 'blog_unwind_model.dart';

class BlogPaginatedResponseModel {
  final List<BlogUnwindModel> blogs;
  final int totalPages;
  final int totalElements;

  BlogPaginatedResponseModel({
    required this.blogs,
    required this.totalPages,
    required this.totalElements,
  });

  factory BlogPaginatedResponseModel.fromJson(Map<String, dynamic> json) {
    return BlogPaginatedResponseModel(
      blogs: (json['content'] as List)
          .map((e) => BlogUnwindModel.fromJson(e))
          .toList(),
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': blogs.map((e) => e.toJson()).toList(),
      'totalPages': totalPages,
      'totalElements': totalElements,
    };
  }

}

extension BlogPaginatedResponseMapper on BlogPaginatedResponseModel {
  BlogPaginatedEntity toEntity() {
    return BlogPaginatedEntity(
      content: blogs.map((e) => e.toEntity()).toList(),
      totalPages: totalPages,
      totalElements: totalElements,
    );
  }
}
