import 'package:sqflite/sqflite.dart';

import '../models/photo.dart';
import '../services/database_service.dart';

/// Repository thao tác với bảng Photo trong SQLite (wishlist).
class WishlistRepository {
  WishlistRepository(this._db);

  final DatabaseService _db;

  Future<List<Photo>> getAll() async {
    final database = await _db.database;
    final rows = await database.query(
      DatabaseService.photoTable,
      orderBy: 'id ASC',
    );
    return rows.map(Photo.fromDbMap).toList(growable: false);
  }

  Future<bool> contains(int id) async {
    final database = await _db.database;
    final rows = await database.query(
      DatabaseService.photoTable,
      columns: const ['id'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return rows.isNotEmpty;
  }

  Future<Set<int>> getAllIds() async {
    final database = await _db.database;
    final rows = await database.query(
      DatabaseService.photoTable,
      columns: const ['id'],
    );
    return rows.map((r) => r['id'] as int).toSet();
  }

  Future<void> insert(Photo photo) async {
    final database = await _db.database;
    await database.insert(
      DatabaseService.photoTable,
      photo.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> remove(int id) async {
    final database = await _db.database;
    await database.delete(
      DatabaseService.photoTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clear() async {
    final database = await _db.database;
    await database.delete(DatabaseService.photoTable);
  }
}
