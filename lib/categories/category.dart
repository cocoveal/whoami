import 'dart:async';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class Category {
  final String name;

  Category({required this.name});

  Future<List<List<dynamic>>> getCategory() async {
    final csvString =
        await rootBundle.loadString('assets/categories/$name.csv');
    final csv = const CsvToListConverter()
        .convert(csvString,
         shouldParseNumbers: false);
    if (csv.isEmpty) {
      return [
        ['No data']
      ];
    }
    return csv;
  }

  Future<Map<String, dynamic>> getCategories() async {
    Map<String, dynamic> categories = {};

    final Category test = Category(name: 'test');
    var testValue = await test.getCategory().then((value) => value.first);
    categories.putIfAbsent(test.name, () => testValue);

    final Category test2 = Category(name: 'test2');
    var test2Value = await test2.getCategory().then((value) => value.first);
    categories.putIfAbsent(test2.name, () => test2Value);

    return categories;
  }
}