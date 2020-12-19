import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Previous_record extends StatefulWidget {
  @override
  _Previous_recordState createState() => _Previous_recordState();
}

class _Previous_recordState extends State<Previous_record> {
  List<Album> _records = List<Album>();
  var recordsJson;
  Future<List<Album>> getall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    print(token);
    Map<String, String> headers = {};
    headers['token'] = token;
    headers['Content-Type'] = 'application/json; charset=UTF-8';

    var url = "https://pdd-backend.herokuapp.com/api/user/getresults";
    final response = await http.get(
      url,
      headers: headers,
    );
    var records = List<Album>();
    recordsJson = json.decode(response.body);
    for (var recordJson in recordsJson) {
      records.add(Album.fromJson(recordJson));
    }
    print("1");
    print(recordsJson);
    return records;
  }

  deleteAlbum(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    print(token);
    Map<String, String> headerss = {};
    headerss['token'] = token;
    headerss['Content-Type'] = 'application/json; charset=UTF-8';

    final http.Response response = await http.delete(
      'https://pdd-backend.herokuapp.com/api/user/reslut/$id',
      headers: headerss,
    );
  }

  Future<List<Album>> futureAlbum;
  @override
  void initState() {
    getall().then((value) {
      setState(() {
        _records.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 32),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: (_records[index].title == 'Healthy')
                        ? [Color(0xFF6448FE), Color(0xFF5FC6FF)]
                        : [Color(0xFFFE6197), Color(0xFFFFB463)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: [Color(0xFF757575), Color(0xFF212121)]
                          .last
                          .withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(4, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.label,
                              color: Colors.white,
                              size: 38,
                            ),
                            SizedBox(width: 8),
                            Text(
                              _records[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'avenir',
                                fontSize: 38,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      _records[index].date.substring(0, 10),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'avenir',
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _records[index].date.substring(12, 19),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'avenir',
                              fontSize: 28,
                              fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              deleteAlbum(_records[index].id);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            itemCount: _records.length,
          )),
        ],
      ),
    );
  }
}

class Album {
  String id;
  String title;
  String date;

  Album(this.id, this.title, this.date);

  Album.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    date = json['date'];
  }
}
