import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() => _instance;

  DBHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'user.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE users(email TEXT PRIMARY KEY, password TEXT)");
    await db.execute('''
      CREATE TABLE katalog (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        foto TEXT,
        harga INTEGER,
        deskripsi TEXT,
        email TEXT,
        created_at DATETIME,
        updated_at DATETIME
      )
    ''');
    // Additional tables and setup can be added here.
  }

  Future<void> insertUser(String email, String password) async {
     final db = await database;
     await db.insert(
       'users',
       {'email': email, 'password': password},
       conflictAlgorithm: ConflictAlgorithm.replace,
     );
   }
  Future<void> insertKatalog(String email, String nama, int harga, String deskripsi) async {
     final db = await database;
     await db.insert(
       'katalog',
       {'email': email, 'nama': nama, 'harga': harga, 'deskripsi': deskripsi, 'created_at': DateTime.now().toString(), 'updated_at': DateTime.now().toString()},
       conflictAlgorithm: ConflictAlgorithm.replace,
     );
   }
   Future<User?> getLogin(String email, String password) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM users WHERE email = '$email' and password = '$password'");
    if (res.length > 0) {
      return new User.fromMap(res.first);
    }
    return null;
    }

    Future<List<Katalog>> getKatalog() async {
     final db = await database;
     final List<Map<String, dynamic>> maps = await db.query('katalog');
     return List.generate(maps.length, (i) {
       return Katalog.fromMap(maps[i]);
     });
   }


  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
    }
  }
}

class User {
  final String email;
  final String password;

  User({required this.email, required this.password});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      password: map['password'],
    );
  }
}

class Katalog {
    final String email;
    final String nama;
    final int harga;
    final String deskripsi;

    Katalog({required this.email, required this.nama, required this.harga, required this.deskripsi});

    factory Katalog.fromMap(Map<String, dynamic> json) {
      return Katalog(
        email: json['email'],
        nama: json['nama'],
        harga: int.tryParse(json['harga'].toString()) ?? 0,
        deskripsi: json['deskripsi'],
      );
    }
  }