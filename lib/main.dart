import 'package:flutter/material.dart';
import 'package:manajemenbuku/ui/login_screen.dart';
import 'package:manajemenbuku/ui/registration_screen.dart';
import 'package:manajemenbuku/helpers/api_helper.dart';
import 'package:manajemenbuku/ui/add_edit_book_screen.dart';
import 'package:manajemenbuku/ui/book_detail_screen.dart';
import 'package:manajemenbuku/models/user_model.dart';
import 'package:manajemenbuku/helpers/api_helper.dart';
import 'package:manajemenbuku/models/book_model.dart';
import 'package:manajemenbuku/ui/book_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manajemen Buku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Courier New',
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
