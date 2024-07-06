import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static late final storage = FlutterSecureStorage();

  static Future<String?> getValue({required String key}) async {
    return await storage.read(
        key: key,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ));
  }

  static Future<void> setValue(
      {required String key, required String value}) async {
    return await storage.write(
        key: key,
        value: value,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ));
  }
}
