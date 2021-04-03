import 'package:blog_app/welcomepg.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(blogapp());
}

class blogapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My lockdown Blogs 2020-21',
      home: welcomepg(),
    );
  }
}
