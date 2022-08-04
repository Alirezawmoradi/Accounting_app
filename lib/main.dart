import 'package:accounting/home_page.dart';
import 'package:accounting/home_screen.dart';
import 'package:accounting/money.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoneyAdapter());
  await Hive.openBox<Money>('moneyBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static void getData() {
    HomeScreen.moneys.clear();
    Box<Money> hiveBox = Hive.box<Money>('moneyBox');
    for (var value in hiveBox.values) {
      HomeScreen.moneys.add(value);
    }
  }
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(fontFamily: 'vazir'),
        debugShowCheckedModeBanner: false,
        title: 'مدیریت مالی',
        home: const HomePage(),
      );
    }
  }

