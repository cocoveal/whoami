import 'dart:async';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Category {
  final String? name;

  final AssetImage? image;

  Category({this.name, this.image});

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

    final Category berufe = Category(name: 'Berufe', image: const AssetImage('assets/images/Berufe.png'));
    var berufeValue = await berufe.getCategory().then((value) => value.first);
    categories.putIfAbsent(berufe.name!, () => berufeValue);

    final Category tiere = Category(name: 'Tiere', image: const AssetImage('assets/images/Tiere.png'));
    var tiereValue = await tiere.getCategory().then((value) => value.first);
    categories.putIfAbsent(tiere.name!, () => tiereValue);

    final Category staaten = Category(name: 'Staaten', image: const AssetImage('assets/images/Staaten.png'));
    var staatenValue = await staaten.getCategory().then((value) => value.first);
    categories.putIfAbsent(staaten.name!, () => staatenValue);

    final Category filme = Category(name: 'Filme', image: const AssetImage('assets/images/Filme.png'));
    var filmeValue = await filme.getCategory().then((value) => value.first);
    categories.putIfAbsent(filme.name!, () => filmeValue);

    final Category marvel = Category(name: 'Marvel', image: const AssetImage('assets/images/Marvel.png'));
    var marvelValue = await marvel.getCategory().then((value) => value.first);
    categories.putIfAbsent(marvel.name!, () => marvelValue);

    final Category sehenswuerdigkeiten = Category(name: 'Sehenswürdigkeiten', image: const AssetImage('assets/images/Sehenswürdigkeiten.png'));
    var sehenswuerdigkeitenValue =
        await sehenswuerdigkeiten.getCategory().then((value) => value.first);
    categories.putIfAbsent(sehenswuerdigkeiten.name!, () => sehenswuerdigkeitenValue);

    return categories;
  }
}