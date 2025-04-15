class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Cache Error']);

  @override
  String toString() => 'CacheException: $message';
}
