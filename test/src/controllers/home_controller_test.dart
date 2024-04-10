import 'package:estudando/src/controllers/home_controller.dart';
import 'package:estudando/src/models/ebook_model.dart';
import 'package:estudando/src/repositories/ebook_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class EbookRepositoryMock extends Mock implements EbookRepository {}

void main() {
  test('deve preencher a lista corretamente', () async {
    final service = EbookRepositoryMock();
    when(() => service.getEbooks())
        .thenAnswer((_) async => [EbookModel.stub()]);
    final controller = HomeController(service);
    await controller.fetchAllEbooks();
    expect(controller.ebooks.length, 1);
  });
}
