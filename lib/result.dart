import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key? key, this.map}) : super(key: key);
  Map<String, dynamic>? map;
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.map!['Name']),
        Text(widget.map!['Marks'].toString())
      ],
    ));
  }
}
