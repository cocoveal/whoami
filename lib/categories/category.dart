import 'dart:async';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Category {
  final String name;

  Category({required this.name});

  Future<List<List<dynamic>>> getCategory() async {
    final csvString =
        await rootBundle.loadString('assets/categories/$name.csv');
    final csv = const CsvToListConverter()
        .convert(csvString, shouldParseNumbers: false);
    return csv;
  }

  List<dynamic> getTest() {
    Category test = Category(name: 'test');
    List<dynamic> testList = [];
    test.getCategory().then((value) {
      testList = List.from(value[0]);
      print('$testList inside getCategory');
    });
    print('$testList outside getCategory');
    return testList;
  }
}

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context),
        home: Scaffold(
          appBar: AppBar(
            leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
            title:
                const Text('Category', style: TextStyle(color: Colors.white)),
          ),
          body: FutureBuilder(
            future: Category(name: 'test').getCategory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Text('${snapshot.data?.first}');
              }
            },
          ),
        ));
  }
}
