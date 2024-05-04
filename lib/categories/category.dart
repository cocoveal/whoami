import 'dart:async';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class Category {
  final String? name;

  Category({this.name});

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

    final Category berufe = Category(name: 'Berufe');
    var berufeValue = await berufe.getCategory().then((value) => value.first);
    categories.putIfAbsent(berufe.name!, () => berufeValue);

    final Category tiere = Category(name: 'Tiere');
    var tiereValue = await tiere.getCategory().then((value) => value.first);
    categories.putIfAbsent(tiere.name!, () => tiereValue);

    final Category staaten = Category(name: 'Staaten');
    var staatenValue = await staaten.getCategory().then((value) => value.first);
    categories.putIfAbsent(staaten.name!, () => staatenValue);

    final Category filme = Category(name: 'Filme');
    var filmeValue = await filme.getCategory().then((value) => value.first);
    categories.putIfAbsent(filme.name!, () => filmeValue);

    final Category marvel = Category(name: 'Marvel');
    var marvelValue = await marvel.getCategory().then((value) => value.first);
    categories.putIfAbsent(marvel.name!, () => marvelValue);

    final Category sehenswuerdigkeiten = Category(name: 'Sehenswürdigkeiten');
    var sehenswuerdigkeitenValue =
        await sehenswuerdigkeiten.getCategory().then((value) => value.first);
    categories.putIfAbsent(sehenswuerdigkeiten.name!, () => sehenswuerdigkeitenValue);

    return categories;
  }
}