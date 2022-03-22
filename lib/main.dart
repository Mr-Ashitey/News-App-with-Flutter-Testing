import 'package:flutter/material.dart';
import 'package:flutter_testing/provider/news_change_notifier.dart';
import 'package:flutter_testing/services/news_service.dart';
import 'package:provider/provider.dart';

import 'screens/news_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News App",
      home: ChangeNotifierProvider.value(
        value: NewsChangeNotifier(NewsService()),
        child: const NewsPage(),
      ),
    );
  }
}
