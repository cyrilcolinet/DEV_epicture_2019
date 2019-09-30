import 'package:http/http.dart' as http;
import '../main.dart' as main;
import 'dart:convert';

class Post {
  final String userId;
  final int id;
  final String avatar;

  Post({this.userId, this.id, this.avatar});

  void debug() {
    print(this.userId);
    print(this.id);
    print(this.avatar);
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['url'],
      id: json['id'],
      avatar: json['avatar'],
    );
  }
}

Future<Map<String, dynamic>> getRequest(String url, String section) async {
  print(main.header);
  final response = await http.get(
    url,
    headers: main.header,
  );
  return json.decode(response.body);
}