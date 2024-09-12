import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
final httpProvider=Provider((ref)=>http.Client());
final secureStorageProvider=Provider((ref)=>const FlutterSecureStorage());