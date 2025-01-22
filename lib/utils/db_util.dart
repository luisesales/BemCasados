import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static Future<sql.Database> openDatabaseConnection() async {
    final databasePath = await sql.getDatabasesPath();

    // vamos criar um db para salvar PRODUCTS criados por um FORNECEDOR
    final pathToDatabase = path.join(databasePath, 'users.db');

    return sql.openDatabase(
      pathToDatabase,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, price DOUBLE, image TEXT, latitude REAL, longitude REAL, address TEXT, phone TEXT, email TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.openDatabaseConnection();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm
          .replace, //se algo conflitante for inserido, substitui
    );
  }

  static Future<void> delete(String table, String id) async {
    final db = await DbUtil.openDatabaseConnection();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.openDatabaseConnection();
    return db.query(table);
  }
}
