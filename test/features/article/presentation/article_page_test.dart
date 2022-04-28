import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/src/features/articles/presentation/article_page.dart';
import 'package:flutter_testing/src/features/news/presentation/news_page.dart';

import '../../../reusable_mocks.dart';

void main() {
  late MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
  });

  testWidgets("""Tapping on the first excerpt opens the article page
  where the full article content is displayed""", (WidgetTester tester) async {
    ReusableMocks.arrangeNewsServiceReturns3Articles(mockNewsService);

    await tester.pumpWidget(ReusableMocks.createNewsPage(mockNewsService));
    await tester.pump();

    await tester.tap(find.text("Test 1"));
    await tester.pumpAndSettle();

    expect(find.byType(NewsPage), findsNothing);
    expect(find.byType(ArticlePage), findsOneWidget);

    expect(find.text("Test 1"), findsOneWidget);
    expect(find.text("Test 1 Content"), findsOneWidget);
  });
}
