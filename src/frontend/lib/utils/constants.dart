import 'package:frontend/utils/api.dart';
import 'package:intl/intl.dart';

const proto = 'http://';
const baseUrl = '127.0.0.1:8000/';
const baseUrlWithProtocol = '${proto}127.0.0.1:8000/';
const apiUrl = '$proto${baseUrl}api/';

typedef ApiObject = Map<String, dynamic>;

final apiClient = ApiClient();

final dtFormatter = DateFormat.yMMMd();
final dtFormatWithTime = DateFormat.yMMMd().add_jms();

// Remove this function when intl implements a function to format durations
String formatPostTimeStamp(DateTime createdAt) {
  final utcNow = DateTime.now().toUtc();
  final diff = utcNow.difference(createdAt);

  if (diff.inDays > 0) {
    if (diff.inDays > 1) {
      return DateFormat.MMMd().format(createdAt);
    }
    return '${diff.inDays}d';
  } else if (diff.inHours > 0) {
    return '${diff.inHours}h';
  } else if (diff.inMinutes > 0) {
    return '${diff.inMinutes}m';
  } else {
    return '${diff.inSeconds}s';
  }
}
