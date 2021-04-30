import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Data {
  static Box<bool> boolBox = Hive.box<bool>('bool');
  static Box<String> stringBox = Hive.box<String>('string');
  static Box<int> intBox = Hive.box<int>('int');
  static Box<double> doubleBox = Hive.box<double>('double');

  static void init() async {
    await Hive.initFlutter();
    await Hive.openBox<bool>('bool');
    await Hive.openBox<String>('string');
    await Hive.openBox<double>('double');
    await Hive.openBox<int>('int');
  }
}
