import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../reusable_mocks.dart';

void main() {
  late MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
  });

  testWidgets("title is displayed", (WidgetTester tester) async {
    ReusableMocks.arrangeNewsServiceReturns3Articles(mockNewsService);

    await tester.pumpWidget(ReusableMocks.createNewsPage(mockNewsService));
    expect(find.text("News"), findsOneWidget);
  });

  testWidgets("progress indicator is shown", (WidgetTester tester) async {
    ReusableMocks.arrangeNewsServiceReturns3ArticlesAfter2SecondWait(
        mockNewsService);

    await tester.pumpWidget(ReusableMocks.createNewsPage(mockNewsService));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // using this method, we can wait for the future to complete
    // all set timers in tests are fake, so 2 seconds don't necessarily mean 2 seconds
    // so we use pumpAndSettle() to ensure that all timers and animations are completed
    await tester.pumpAndSettle();
  });
  testWidgets("articles are displayed", (WidgetTester tester) async {
    ReusableMocks.arrangeNewsServiceReturns3Articles(mockNewsService);

    await tester.pumpWidget(ReusableMocks.createNewsPage(mockNewsService));
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
