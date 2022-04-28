import 'package:flutter_test/flutter_test.dart';

import '../../../reusable_mocks.dart';

void main() {
  late MockNewsService mockNewsService;
  setUp(() {
    mockNewsService = MockNewsService();
  });

  test("checking the return value of getArticles method from NewsService",
      () async {
    ReusableMocks.arrangeNewsServiceReturns3ArticlesAfter2SecondWait(
        mockNewsService);
    final response = await mockNewsService.getArticles();

    expect(response, ReusableMocks.fakeArticlesList);
  });
}
