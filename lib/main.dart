// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sessio7/photos_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Dio dio = Dio();
  List<Photos>? photos;
  void getCats() async {
    var response = await dio.post("https://jsonplaceholder.typicode.com/posts",
        data: {"title": "Aly", "body": "Hello", "userId": 1});
    print(response.data);
    print(response.statusCode);
    var mapdata = response.data;
    // convert list of json to list of photos

    photos = [];
    for (var item in mapdata) {
      photos!.add(Photos.fromJson(item));
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Image.network(
                      photos![index].url.toString(),
                      width: 200,
                    ),
                    title: Text(photos![index].id.toString()),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: photos?.length ?? 0,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                getCats();
              },
              child: Text("Get Data"),
            ),
          ],
        ),
      ),
    );
  }
}
