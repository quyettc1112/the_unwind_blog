import 'package:flutter/material.dart';
import '../../domain/entities/blog_entity.dart';
import '../../services/data_service.dart';

class BlogProvider extends ChangeNotifier {
  final DataService _dataService = DataService();
  List<Blog> _blogs = [];
  List<Blog> _bookmarkedBlogs = [];
  List<Blog> _filteredBlogs = [];
  String _selectedCategory = '';
  List<String> _readingHistory = [];
  bool _isLoading = false;
  
  // Getters
  List<Blog> get blogs => _blogs;
  List<Blog> get bookmarkedBlogs => _bookmarkedBlogs;
  List<Blog> get filteredBlogs => _selectedCategory.isEmpty
      ? _blogs
      : _filteredBlogs;
  String get selectedCategory => _selectedCategory;
  List<String> get categories => _dataService.categories;
  bool get isLoading => _isLoading;
  
  // Initialize blogs
  Future<void> initBlogs() async {
    _isLoading = true;
    notifyListeners();
    
    // Get mock blogs
    _blogs = _dataService.getMockBlogs();
    _filteredBlogs = _blogs;
    
    // Get bookmarked blogs
    await loadBookmarkedBlogs();
    
    // Get reading history
    await loadReadingHistory();
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Load bookmarked blogs
  Future<void> loadBookmarkedBlogs() async {
    final bookmarkedIds = await _dataService.getBookmarkedBlogIds();
    _bookmarkedBlogs = _blogs.where((blog) => bookmarkedIds.contains(blog.id)).toList();
    notifyListeners();
  }
  
  // Load reading history
  Future<void> loadReadingHistory() async {
    _readingHistory = await _dataService.getReadingHistory();
    notifyListeners();
  }
  
  // Filter blogs by category
  void filterByCategory(String category) {
    _selectedCategory = category;
    
    if (category.isEmpty) {
      _filteredBlogs = _blogs;
    } else {
      _filteredBlogs = _blogs.where((blog) => 
        blog.tags.contains(category)
      ).toList();
    }
    
    notifyListeners();
  }
  
  // Clear filter
  void clearFilter() {
    _selectedCategory = '';
    _filteredBlogs = _blogs;
    notifyListeners();
  }
  
  // Toggle bookmark status
  Future<void> toggleBookmark(String blogId) async {
    final isBlogBookmarked = await _dataService.isBlogBookmarked(blogId);
    
    if (isBlogBookmarked) {
      await _dataService.unbookmarkBlog(blogId);
    } else {
      await _dataService.bookmarkBlog(blogId);
    }
    
    await loadBookmarkedBlogs();
  }
  
  // Search blogs
  List<Blog> searchBlogs(String query) {
    if (query.isEmpty) {
      return _blogs;
    }
    
    final lowercaseQuery = query.toLowerCase();
    return _blogs.where((blog) {
      return blog.title.toLowerCase().contains(lowercaseQuery) ||
             blog.subtitle.toLowerCase().contains(lowercaseQuery) ||
             blog.content.toLowerCase().contains(lowercaseQuery) ||
             blog.author.toLowerCase().contains(lowercaseQuery) ||
             blog.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }
  
  // Add blog to reading history
  Future<void> addToReadingHistory(String blogId) async {
    await _dataService.addToReadingHistory(blogId);
    await loadReadingHistory();
  }
  
  // Get blogs from reading history
  List<Blog> getReadingHistoryBlogs() {
    return _readingHistory
        .map((id) => _blogs.firstWhere((blog) => blog.id == id, orElse: () => _blogs.first))
        .toList();
  }
  
  // Get blog by ID
  Blog getBlogById(String id) {
    return _blogs.firstWhere((blog) => blog.id == id, orElse: () => _blogs.first);
  }
  
  // Check if a blog is bookmarked
  Future<bool> isBlogBookmarked(String blogId) async {
    return await _dataService.isBlogBookmarked(blogId);
  }
}