// ignore_for_file: avoid_print

import 'dart:io';

import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart' as auth_io;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:path/path.dart'; // Import the path package
import 'package:sqflite/sqflite.dart';

// Utils class with a static method to initialize the database
class Utils {
  static Future<String> init() async {
    // Open the database
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'local_db.db');

    // Ensure the directory exists
    await Directory(databasesPath).create(recursive: true);

    // Delete the database if it already exists
    await deleteDatabase(path);

    // Create the database
    var db = await openDatabase(path, version: 1, onCreate: (db, version) {
      // Create your database schema here
    });

    return path; // Return the path to the database
  }
}

// Function to authenticate with Google Drive
Future<auth.AutoRefreshingAuthClient> authenticate() async {
  var credentials = auth.ServiceAccountCredentials.fromJson({
    // Your service account credentials here
  });

  var scopes = [drive.DriveApi.driveScope];

  var client = await auth_io.clientViaServiceAccount(credentials, scopes);

  return client;
}

// Function to upload file to Google Drive
Future<void> uploadFile(
    auth.AutoRefreshingAuthClient client, String filePath) async {
  var driveApi = drive.DriveApi(client);

  var file = await driveApi.files.create(
    drive.File()
      ..name = 'backup.db', // Change 'backup.db' to your desired file name
    uploadMedia: drive.Media(
        http.ByteStream.fromBytes(File(filePath).readAsBytesSync()),
        File(filePath).lengthSync()),
  );

  print('File uploaded! ID: ${file.id}');
}

// Function to backup local database to Google Drive
Future<void> backupDatabase() async {
  // Initialize the database and get the path
  var path = await Utils.init();

  // Authenticate with Google Drive
  var client = await authenticate();

  // Upload data to Google Drive
  await uploadFile(client, path);
}
