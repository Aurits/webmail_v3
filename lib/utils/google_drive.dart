// ignore_for_file: avoid_print

import 'dart:io'; // Add this import statement

import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:googleapis_auth/auth_io.dart' as auth_io;
import 'package:http/http.dart' as http;

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
Future<void> uploadFile(auth.AutoRefreshingAuthClient client, String filePath) async {
  var driveApi = drive.DriveApi(client);
  
  var file = await driveApi.files.create(
    drive.File()..name = 'local_db.db', // Change 'backup.db' to your desired file name
    uploadMedia: drive.Media(http.ByteStream.fromBytes(File(filePath).readAsBytesSync()), File(filePath).lengthSync()),
  );

  print('File uploaded! ID: ${file.id}');
}

// Function to backup local database to Google Drive
Future<void> backupDatabase() async {
  // Retrieve data from local database
  // Replace this with your code to retrieve data from your local database
  // Example: var data = await myLocalDatabase.query('SELECT * FROM table');
  
  // Authenticate with Google Drive
  var client = await authenticate();
  
  // Upload data to Google Drive
  await uploadFile(client, '/path/to/your/local/database.db'); // Replace '/path/to/your/local/database.db' with the path to your local database file
}

// Call the backupDatabase function to initiate the backup process
backupDatabase();
