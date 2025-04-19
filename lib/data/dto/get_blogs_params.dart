class GetBlogsParams {
  final int pageNo;
  final int pageSize;
  final String? title;
  final int? categoryId;

  GetBlogsParams({
    required this.pageNo,
    required this.pageSize,
    this.title,
    this.categoryId,
  });
}