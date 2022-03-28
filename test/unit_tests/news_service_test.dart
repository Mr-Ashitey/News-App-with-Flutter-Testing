import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/src/features/news/application/news_service.dart';
import 'package:mocktail/mocktail.dart';

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

  test("checking the return value of getArticles method from NewsService",
      () async {
    arrangeNewsServiceReturns3Articles();
    final response = await mockNewsService.getArticles();

    expect(response, ReusableMocks.fakeArticlesList);
  });
}
