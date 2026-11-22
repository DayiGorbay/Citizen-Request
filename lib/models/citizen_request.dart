import 'dart:convert';

class CitizenRequest {
  const CitizenRequest({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.address,
    required this.priority,
    this.status = 'ثبت شده',
  });

  final String id;
  final String title;
  final String category;
  final String description;
  final String address;
  final String priority;
  final String status;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'category': category,
    'description': description,
    'address': address,
    'priority': priority,
    'status': status,
  };

  factory CitizenRequest.fromJson(Map<String, dynamic> json) {
    return CitizenRequest(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String? ?? 'ثبت شده',
    );
  }

  static String encodeList(List<CitizenRequest> requests) =>
      jsonEncode(requests.map((request) => request.toJson()).toList());

  static List<CitizenRequest> decodeList(String data) {
    final decoded = jsonDecode(data) as List<dynamic>;
    return decoded
        .map((item) => CitizenRequest.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
