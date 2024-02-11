// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class GoogleDriveHelper {
  final FlutterAppAuth _appAuth = const FlutterAppAuth();

  Future<void> authenticateAndUpload(File localDatabaseFile) async {
    try {
      final AuthorizationTokenResponse? result =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          '430314973310-jdfm22qbg6scti4u2ai6qofmnhmksl4n.apps.googleusercontent.com', // Replace with your client ID
          'http://localhost/callback', // Use a placeholder redirect URI
          issuer: 'https://accounts.google.com', // Google issuer URL
          scopes: [
            'https://www.googleapis.com/auth/drive.appdata'
          ], // Scope for accessing app data folder
        ),
      );

      final authHeaders = {'Authorization': 'Bearer ${result?.accessToken}'};
      final googleAuthClient = GoogleAuthClient(authHeaders);
      final driveApi = drive.DriveApi(googleAuthClient);

      final fileToUpload = drive.File()
        ..parents = ['appDataFolder']
        ..name = path.basename(localDatabaseFile.absolute.path);

      final response = await driveApi.files.create(
        fileToUpload,
        uploadMedia: drive.Media(
            localDatabaseFile.openRead(), localDatabaseFile.lengthSync()),
      );

      final fileId = response.id;
      print('File uploaded successfully. File ID: $fileId');
    } catch (e) {
      print('Error uploading database to Google Drive: $e');
    }
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}
