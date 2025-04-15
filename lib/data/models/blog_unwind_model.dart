import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';
class BlogUnwindModel extends BlogEntity {
  BlogUnwindModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.content,
    required super.description,
    required super.thumbnailUrl,
    required super.createdAt,
    required super.isPublished,
    required super.tableOfContents,
    super.category,
    super.author,
  });

  factory BlogUnwindModel.fromJson(Map<String, dynamic> json) {
    return BlogUnwindModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      content: json['content'],
      description: json['description'],
      thumbnailUrl: json['thumbnailUrl'],
      createdAt: json['createdAt'],
      isPublished: json['isPublished'],
      tableOfContents: (json['tableOfContents'] as List<dynamic>)
          .map((e) => TableOfContentEntity.fromJson(e))
          .toList(),
      category: json['categoryDto'] != null
          ? BlogCategoryEntity.fromJson(json['categoryDto'])
          : null,
      author: json['authorDto'] != null
          ? BlogAuthorEntity.fromJson(json['authorDto'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'content': content,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'createdAt': createdAt,
      'isPublished': isPublished,
      'tableOfContents': tableOfContents.map((e) => e.toJson()).toList(),
      'categoryDto': category?.toJson(),
      'authorDto': author?.toJson(),
    };
  }
}
