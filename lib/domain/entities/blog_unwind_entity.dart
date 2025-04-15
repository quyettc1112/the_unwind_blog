class BlogEntity {
  final int id;
  final String title;
  final String slug;
  final String content;
  final String description;
  final String thumbnailUrl;
  final String createdAt;
  final bool isPublished;
  final BlogCategoryEntity? category;
  final BlogAuthorEntity? author;
  final List<TableOfContentEntity> tableOfContents;

  BlogEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    required this.description,
    required this.thumbnailUrl,
    required this.createdAt,
    required this.isPublished,
    this.category,
    this.author,
    required this.tableOfContents,
  });
}

class BlogCategoryEntity {
  final int id;
  final String name;
  final String slug;

  const BlogCategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory BlogCategoryEntity.fromJson(Map<String, dynamic> json) {
    return BlogCategoryEntity(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }
}

class BlogAuthorEntity {
  final String username;
  final String email;
  final String displayName;
  final String createdAt;

  const BlogAuthorEntity({
    required this.username,
    required this.email,
    required this.displayName,
    required this.createdAt,
  });

  factory BlogAuthorEntity.fromJson(Map<String, dynamic> json) {
    return BlogAuthorEntity(
      username: json['username'],
      email: json['email'],
      displayName: json['displayName'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'displayName': displayName,
      'createdAt': createdAt,
    };
  }
}

class TableOfContentEntity {
  final String text;
  final int level;
  final int orderNumber;

  const TableOfContentEntity({
    required this.text,
    required this.level,
    required this.orderNumber,
  });

  factory TableOfContentEntity.fromJson(Map<String, dynamic> json) {
    return TableOfContentEntity(
      text: json['text'],
      level: json['level'],
      orderNumber: json['orderNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'level': level,
      'orderNumber': orderNumber,
    };
  }
}