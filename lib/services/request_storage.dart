import 'package:shared_preferences/shared_preferences.dart';

import '../models/citizen_request.dart';

class RequestStorage {
  static const _requestsKey = 'citizen_requests';
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  Future<List<CitizenRequest>> loadRequests() async {
    final data = await _preferences.getString(_requestsKey);
    if (data == null || data.isEmpty) return [];
    return CitizenRequest.decodeList(data);
  }

  Future<void> saveRequests(List<CitizenRequest> requests) async {
    await _preferences.setString(
      _requestsKey,
      CitizenRequest.encodeList(requests),
    );
  }
}
