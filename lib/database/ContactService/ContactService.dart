import 'package:contactlab/database/helpers/DataBaseHelper.dart';
import 'package:sqflite/sqflite.dart';


class ContactService {
  final DatabaseHelper _dbHelper;

  ContactService(this._dbHelper);

  Future<void> insertContact(String name, String phone) async {
    final db = await _dbHelper.database;
    await db.insert(
      'contacts',
      {'name': name, 'phone': phone},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateContact(int id, String name, String phone) async {
    final db = await _dbHelper.database;
    await db.update(
      'contacts',
      {'name': name, 'phone': phone},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteContact(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getContacts() async {
    final db = await _dbHelper.database;
    return await db.query('contacts');
  }
  
}
