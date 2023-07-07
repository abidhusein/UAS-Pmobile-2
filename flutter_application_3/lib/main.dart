import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KBBIResult {
  final String word;
  final List<String> definitions;

  KBBIResult({
    required this.word,
    required this.definitions,
  });

  factory KBBIResult.fromJson(Map<String, dynamic> json) {
    return KBBIResult(
      word: json['word'],
      definitions: List<String>.from(json['definitions']),
    );
  }
}

class KBBIAPIService {
  static Future<KBBIResult> searchWord(String query) async {
    final response = await http
        .get(Uri.parse('https://kbbi-api-amm.herokuapp.com/search?q=$query'));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return KBBIResult.fromJson(data);
    } else {
      throw Exception('Failed to search word');
    }
  }
}

class KBBIApp extends StatefulWidget {
  @override
  _KBBIAppState createState() => _KBBIAppState();
}

class _KBBIAppState extends State<KBBIApp> {
  String query = '';
  KBBIResult? result;

  Future<void> searchWord() async {
    if (query.isNotEmpty) {
      try {
        final KBBIResult kbbiResult = await KBBIAPIService.searchWord(query);
        setState(() {
          result = kbbiResult;
        });
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('KBBI Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter a word',
                ),
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  searchWord();
                },
                child: Text('Search'),
              ),
              SizedBox(height: 16.0),
              if (result != null)
                Text(
                  'Word: ${result!.word}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (result != null) SizedBox(height: 8.0),
              if (result != null)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: result!.definitions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(result!.definitions[index]),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(KBBIApp());
}
