import 'package:frontend/utils/api.dart';

const prefix = 'http://';
const baseUrl = '127.0.0.1:8000/';
const apiUrl = '$prefix${baseUrl}api/';

typedef ApiObject = Map<String, dynamic>;

final apiClient = ApiClient();
