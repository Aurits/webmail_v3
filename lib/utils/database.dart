import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Utils {
  static Future<String> getDatabasePath() async {
    // Get the directory for storing databases
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = appDocDir.path + '/local_db.db';
    return dbPath;
  }

  static Future<Database> init() async {
    String dbPath = await getDatabasePath();
    var db = await openDatabase(dbPath);
    return db;
  }
}
