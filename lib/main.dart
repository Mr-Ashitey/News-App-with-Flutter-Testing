import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/features/news/application/news_service.dart';
import 'src/features/news/presentation/news_page.dart';
import 'src/features/news/data/news_change_notifier.dart';

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
