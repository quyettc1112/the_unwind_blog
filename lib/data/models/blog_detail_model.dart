import '../../domain/entities/blog_detail_entity.dart';

class BlogDetailModel extends BlogDetailEntity {
  BlogDetailModel({
    required int id,
    required String title,
    required String slug,
    required String content,
    required String description,
    required String thumbnailUrl,
    required String createdAt,
    required bool isPublished,
    CategoryDto? categoryDto,
    dynamic seriesId,
    dynamic isSeries,
    dynamic seriesOrder,
    AuthorDto? authorDto,
    List<TableOfContents>? tableOfContents,
  }) : super(
    id: id,
    title: title,
    slug: slug,
    content: content,
    description: description,
    thumbnailUrl: thumbnailUrl,
    createdAt: createdAt,
    isPublished: isPublished,
    categoryDto: categoryDto,
    seriesId: seriesId,
    isSeries: isSeries,
    seriesOrder: seriesOrder,
    authorDto: authorDto,
    tableOfContents: tableOfContents,
  );

  factory BlogDetailModel.fromJson(Map<String, dynamic> json) {
    return BlogDetailModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      content: json['content'],
      description: json['description'],
      thumbnailUrl: json['thumbnailUrl'],
      createdAt: json['createdAt'],
      isPublished: json['isPublished'],
      categoryDto: json['categoryDto'] != null
          ? CategoryDto.fromJson(json['categoryDto'])
          : null,
      seriesId: json['seriesId'],
      isSeries: json['isSeries'],
      seriesOrder: json['seriesOrder'],
      authorDto: json['authorDto'] != null
          ? AuthorDto.fromJson(json['authorDto'])
          : null,
      tableOfContents: (json['tableOfContents'] as List<dynamic>?)
          ?.map((e) => TableOfContents.fromJson(e))
          .toList(),
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
      'categoryDto': categoryDto?.toJson(),
      'seriesId': seriesId,
      'isSeries': isSeries,
      'seriesOrder': seriesOrder,
      'authorDto': authorDto?.toJson(),
      'tableOfContents':
      tableOfContents?.map((e) => e.toJson()).toList(),
    };
  }
}


extension BlogDetailModelMapper on BlogDetailModel {
  BlogDetailEntity toEntity() {
    return BlogDetailEntity(
      id: id,
      title: title,
      slug: slug,
      content: content,
      description: description,
      thumbnailUrl: thumbnailUrl,
      createdAt: createdAt,
      isPublished: isPublished,
      categoryDto: categoryDto,
      seriesId: seriesId,
      isSeries: isSeries,
      seriesOrder: seriesOrder,
      authorDto: authorDto,
      tableOfContents: tableOfContents,
    );
  }
}
