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

String baseUrl = "https://api.imgur.com/3";

/// Get request from url
/// Return future of data
Future<Map<String, dynamic>> getRequest(String url, String section) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Call request with corresponded headers
    final response = await http.get(baseUrl + url,
        headers: {
            'Authorization': 'Bearer ' + prefs.getString("access_token")
        },
    );

    // Return decoded responses
    if (response.statusCode == 200) {
        print(response.statusCode);
        return json.decode(response.body);
    }
    print(response.statusCode);
    print(response.reasonPhrase);
}

Future<String> postRequest(String url, {bool isAnonymousRequest = false, Map json}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print("doing request");
    print(json);
    if (!isAnonymousRequest) {
        final response = await http.post(baseUrl + url, headers: {
            'Authorization': 'Bearer ' + prefs.getString("access_token"),
        }, body: json
        );
        if (response.statusCode == 200) {
            print(response.statusCode);
            return response.body;
        }
        print(response.statusCode);
        print(response.reasonPhrase);
        return "request failed";
    } else {
        final response = await http.post(baseUrl + url, headers: {
            'Authorization': 'Client-ID 9f0153451f88a91'
        }, body: json
        );
        if (response.statusCode == 200) {
            print(response.statusCode);
            return response.body;
        }
        print(response.statusCode);
        print(response.reasonPhrase);
        return "request failed";
    }
}

Future<String> putRequest(String url, {bool isAnonymousRequest = false, String json = ""}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!isAnonymousRequest) {
        final response = await http.post(baseUrl + url, headers: {
            'Authorization': 'Bearer ' + prefs.getString("access_token")
        }, body: json
        );
        print("STATUS CODE : " + response.statusCode.toString());
        if (response.statusCode == 200)
            return response.body;
        return "request failed";
    } else {
        final response = await http.post(baseUrl + url, headers: {
            'Authorization': 'Client-ID 9f0153451f88a91'
        }, body: json
        );
        print("STATUS CODE : " + response.statusCode.toString());
        if (response.statusCode == 200)
            return response.body;
        return "request failed";
    }
}