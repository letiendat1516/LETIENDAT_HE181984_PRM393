import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/photo.dart';

class PhotoApiException implements Exception {
  final String message;
  PhotoApiException(this.message);
  @override
  String toString() => 'PhotoApiException: $message';
}

/// Service gọi API JSONPlaceholder để lấy danh sách photo.
class PhotoApiService {
  PhotoApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static final Uri _endpoint =
      Uri.parse('https://jsonplaceholder.typicode.com/photos');

  Future<List<Photo>> fetchPhotos({int limit = 100}) async {
    try {
      final response = await _client.get(_endpoint);
      if (response.statusCode != 200) {
        throw PhotoApiException(
          'Lỗi mạng: HTTP ${response.statusCode}',
        );
      }
      final List<dynamic> raw = json.decode(response.body) as List<dynamic>;
      final List<Photo> photos = raw
          .cast<Map<String, dynamic>>()
          .map(Photo.fromJson)
          .toList(growable: false);
      if (limit > 0 && photos.length > limit) {
        return photos.sublist(0, limit);
      }
      return photos;
    } on PhotoApiException {
      rethrow;
    } catch (e) {
      throw PhotoApiException('Không thể tải dữ liệu: $e');
    }
  }

  void dispose() => _client.close();
}
