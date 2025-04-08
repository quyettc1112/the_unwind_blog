class Blog {
  final String id;
  final String title;
  final String subtitle;
  final String content;
  final String author;
  final String authorImageUrl;
  final DateTime publishDate;
  final String readDuration;
  final List<String> tags;
  final String imageUrl;
  final int likes;
  final int comments;
  
  Blog({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.author,
    required this.authorImageUrl,
    required this.publishDate,
    required this.readDuration,
    required this.tags,
    required this.imageUrl,
    required this.likes,
    required this.comments,
  });

  // Create a copy of this blog with updated fields
  Blog copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? content,
    String? author,
    String? authorImageUrl,
    DateTime? publishDate,
    String? readDuration,
    List<String>? tags,
    String? imageUrl,
    int? likes,
    int? comments,
  }) {
    return Blog(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
      author: author ?? this.author,
      authorImageUrl: authorImageUrl ?? this.authorImageUrl,
      publishDate: publishDate ?? this.publishDate,
      readDuration: readDuration ?? this.readDuration,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
    );
  }

  // Convert from JSON
  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      content: json['content'],
      author: json['author'],
      authorImageUrl: json['authorImageUrl'],
      publishDate: DateTime.parse(json['publishDate']),
      readDuration: json['readDuration'],
      tags: List<String>.from(json['tags']),
      imageUrl: json['imageUrl'],
      likes: json['likes'],
      comments: json['comments'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'content': content,
      'author': author,
      'authorImageUrl': authorImageUrl,
      'publishDate': publishDate.toIso8601String(),
      'readDuration': readDuration,
      'tags': tags,
      'imageUrl': imageUrl,
      'likes': likes,
      'comments': comments,
    };
  }
}