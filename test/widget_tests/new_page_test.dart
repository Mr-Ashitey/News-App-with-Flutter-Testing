import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/src/features/news/application/news_service.dart';
import 'package:flutter_testing/src/features/news/presentation/news_page.dart';
import 'package:flutter_testing/src/features/news/data/news_change_notifier.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../reusable_mocks.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
  });

  void arrangeNewsServiceReturns3Articles() {
    when(() => mockNewsService.getArticles())
        .thenAnswer((_) async => ReusableMocks.fakeArticlesList);
  }

  void arrangeNewsServiceReturns3ArticlesAfter2SecondWait() {
    when(() => mockNewsService.getArticles()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return ReusableMocks.fakeArticlesList;
    });
  }

  Widget createNewsPage() {
    return MaterialApp(
      title: "News App",
      home: ChangeNotifierProvider.value(
        value: NewsChangeNotifier(mockNewsService),
        child: const NewsPage(),
      ),
    );
  }

  testWidgets("title is displayed", (WidgetTester tester) async {
    arrangeNewsServiceReturns3Articles();

    await tester.pumpWidget(createNewsPage());
    expect(find.text("News"), findsOneWidget);
  });

  testWidgets("progress indicator is shown", (WidgetTester tester) async {
    arrangeNewsServiceReturns3ArticlesAfter2SecondWait();

    await tester.pumpWidget(createNewsPage());
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // using this method, we can wait for the future to complete
    // all set timers in tests are fake, so 2 seconds don't necessarily mean 2 seconds
    // so we use pumpAndSettle() to ensure that all timers and animations are completed
    await tester.pumpAndSettle();
  });
  testWidgets("articles are displayed", (WidgetTester tester) async {
    arrangeNewsServiceReturns3Articles();

    await tester.pumpWidget(createNewsPage());
    await tester.pump();

    for (int i = 0; i < ReusableMocks.fakeArticlesList.length; i++) {
      expect(
          find.text(ReusableMocks.fakeArticlesList[i].title!), findsOneWidget);
      expect(find.text(ReusableMocks.fakeArticlesList[i].content!),
          findsOneWidget);
    }

    // using this method, we can wait for the future to complete
    // all set timers in tests are fake, so 2 seconds don't necessarily mean 2 seconds
    // so we use pumpAndSettle() to ensure that all timers and animations are completed
    // await tester.pumpAndSettle();
  });
}
