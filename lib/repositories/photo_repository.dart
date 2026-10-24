import '../models/photo.dart';
import '../services/photo_api_service.dart';

/// Repository nguồn dữ liệu Photo lấy từ API JSONPlaceholder.
class PhotoRepository {
  PhotoRepository(this._api);

  final PhotoApiService _api;

  Future<List<Photo>> getPhotos({int limit = 100}) {
    return _api.fetchPhotos(limit: limit);
  }
}
