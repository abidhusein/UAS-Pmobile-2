# UAS-Pmobile-2

<body>
    <table border="1">
        <tr>
            <th> Nama</th>
            <th>NIM</th>
            <th>Kelas</th>
        </tr>
        <tr>
            <td>Abid Husein</td>
            <td>312110031</td>
            <td>TI.21.A.1</td>
        </tr>
    </table>
</body>

# Aplikasi Flutter dengan Menggunkan API 
API `https://booking.kai.id/api/stations2`

## Output Program
![Gambar1](src/UAS%20Pmobile%202.png)
<br>
![Gambar1](src/UAS%20Pmobile%202_2.png)

### Program

* main.dart
```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> stations = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://booking.kai.id/api/stations2'));

    if (response.statusCode == 200) {
      setState(() {
        stations = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Booking KAI Antar Kota'),
        ),
        body: ListView.builder(
          itemCount: stations.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Code: ${stations[index]['code']}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Name: ${stations[index]['name']}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'City: ${stations[index]['city']}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 145, 127, 68),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'City Name: ${stations[index]['cityname']}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 145, 127, 68),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

```

* pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.4
```


