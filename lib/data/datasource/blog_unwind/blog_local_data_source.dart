import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/cache_exception.dart';
import '../../models/blog_unwind_model.dart';

abstract class BlogLocalDataSource {
  Future<void> cacheBlogList(List<BlogUnwindModel> blogs);
  Future<List<BlogUnwindModel>> getCachedBlogList();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String cacheKey = 'CACHED_BLOG_LIST';

  BlogLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheBlogList(List<BlogUnwindModel> blogs) async {
    final blogJsonList = blogs.map((e) => e.toJson()).toList();
    final encoded = jsonEncode(blogJsonList);
    await sharedPreferences.setString(cacheKey, encoded);
  }

  @override
  Future<List<BlogUnwindModel>> getCachedBlogList() async {
    final jsonString = sharedPreferences.getString(cacheKey);
    if (jsonString != null) {
      final decoded = jsonDecode(jsonString) as List;
      return decoded.map((e) => BlogUnwindModel.fromJson(e)).toList();
    } else {
      throw  CacheException('No cached blog data found');
    }
  }
}
