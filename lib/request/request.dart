import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Post class
class Post {
    final String userId;
    final int id;
    final String avatar;

    /// Constructor
    Post({this.userId, this.id, this.avatar});

    /// Debug results
    void debug() {
        print(this.userId);
        print(this.id);
        print(this.avatar);
    }

    /// Build a fromJson method
    factory Post.fromJson(Map<String, dynamic> json) {
        return Post(
            userId: json['url'],
            id: json['id'],
            avatar: json['avatar'],
        );
    }
}

/// Get request from url
/// Return future of data
Future<Map<String, dynamic>> getRequest(String url, String section) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Call request with corresponded headers
    final response = await http.get(url,
        headers: {
            'Authorization': 'Bearer ' + prefs.getString("access_token")
        },
    );

    // Return decoded responses
    return json.decode(response.body);
}
