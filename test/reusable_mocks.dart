import 'package:flutter/material.dart';
import 'package:flutter_testing/src/features/articles/domain/article.dart';
import 'package:flutter_testing/src/features/news/application/news_service.dart';
import 'package:flutter_testing/src/features/news/data/news_change_notifier.dart';
import 'package:flutter_testing/src/features/news/presentation/news_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockNewsService extends Mock implements NewsService {}

class ReusableMocks {
  static Widget createNewsPage(mockNewsService) {
    return MaterialApp(
      title: "News App",
      home: ChangeNotifierProvider.value(
        value: NewsChangeNotifier(mockNewsService),
        child: const NewsPage(),
      ),
    );
  }

  static final List<Article> fakeArticlesList = [
    Article(title: "Test 1", content: "Test 1 Content"),
    Article(title: "Test 2", content: "Test 2 Content"),
    Article(title: "Test 3", content: "Test 3 Content"),
  ];

  static void arrangeNewsServiceReturns3Articles(mockNewsService) {
    when(() => mockNewsService.getArticles())
        .thenAnswer((_) async => ReusableMocks.fakeArticlesList);
  }

  static void arrangeNewsServiceReturns3ArticlesAfter2SecondWait(
      mockNewsService) {
    when(() => mockNewsService.getArticles()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return ReusableMocks.fakeArticlesList;
    });
  }
}
