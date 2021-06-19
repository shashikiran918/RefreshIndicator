import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: _PullToRefreshExample(),
    );
  }
}

class _PullToRefreshExample extends StatefulWidget {
  @override
  _PullToRefreshExampleState createState() => _PullToRefreshExampleState();
}

class _PullToRefreshExampleState extends State<_PullToRefreshExample> {

  final _data = <WordPair>[];

  @override
  void initState() {
    super.initState();
    _data.addAll(generateWordPairs().take(20));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Refresh'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        padding: EdgeInsets.all(20.0),
        itemBuilder: (context, index) {
          WordPair wordPair = _data[index];

          return _buildListItem(wordPair.asString, context);
        },
        itemCount: _data.length,
      ),
    );
  }

  Widget _buildListItem(String word, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(word),
      ),
    );
  }

  Future _refreshData() async {
    await Future.delayed(Duration(seconds: 3));
    _data.clear();
    _data.addAll(generateWordPairs().take(20));

    setState(() {});
  }
}