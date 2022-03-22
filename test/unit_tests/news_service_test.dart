import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/model/article.dart';
import 'package:flutter_testing/services/news_service.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late MockNewsService mockNewsService;
  setUp(() {
    mockNewsService = MockNewsService();
  });

  final List<Article> fakeArticlesList = [
    Article(title: "Test 1", content: "Test 1 Content"),
    Article(title: "Test 2", content: "Test 2 Content"),
    Article(title: "Test 3", content: "Test 3 Content"),
  ];

  void arrangeNewsServiceReturns3Articles() {
    when(() => mockNewsService.getArticles())
        .thenAnswer((_) async => fakeArticlesList);
  }

  test("checking the return value of getArticles method from NewsService",
      () async {
    arrangeNewsServiceReturns3Articles();
    final response = await mockNewsService.getArticles();

    expect(response, fakeArticlesList);
  });
}
