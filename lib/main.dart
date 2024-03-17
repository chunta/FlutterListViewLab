import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:json_to_list_flutter/Model/post.dart';
import 'package:json_to_list_flutter/View/loading_indicator.dart';
import 'package:json_to_list_flutter/View/post_list.dart';
import 'package:system_proxy/system_proxy.dart';

class ProxiedHttpOverrides extends HttpOverrides {
  ProxiedHttpOverrides(this._host, this._port);

  String _port;
  String _host;

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      // set proxy
      ..findProxy = (uri) {
        return _host != null ? "PROXY $_host:$_port;" : 'DIRECT';
      };
  }
}

Future<void> main() async {
  // add this, and it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized(); 

  Map<String, String>? proxy = await SystemProxy.getProxySettings();
  proxy ??= {'host': '127.0.0.1', 'port': '8888'};
  HttpOverrides.global = ProxiedHttpOverrides(proxy['host']!, proxy['port']!);
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Container(
      color: Colors.red,
      child: const Text("123")) );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Post>> postsFuture = getPosts();

  static Future<List<Post>> getPosts() async {
    var url = Uri.parse(
        "https://dl.dropboxusercontent.com/s/zkvbrf79zuzqvjy/labmocklist.json");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    Map<String, dynamic> jsonMap = json.decode(response.body);
    String contentString = json.encode(jsonMap['content']);
    final List body = json.decode(contentString);
    return body.map((e) => Post.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            } else if (snapshot.hasData) {
              final posts = snapshot.data!;
              return Column(
                children: [
                  Container(
                      color: const Color.fromARGB(0, 0, 0, 0),
                      child:
                          const SizedBox(height: 20, width: double.infinity)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Photo Gallery',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(child: PostList(posts: posts))
                ],
              );
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }
}
