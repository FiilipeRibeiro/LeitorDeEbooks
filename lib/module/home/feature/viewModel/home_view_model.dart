import '../../../../config/emit_notifier.dart';
import '../../models/ebook.dart';
import '../network/ebook_network.dart';

class HomeState {
  List<Ebook> ebooks;
  List<Ebook> favoriteEbooks;

  HomeState({
    required this.ebooks,
    required this.favoriteEbooks,
  });
}

class HomeViewModelImpl extends HomeViewModel {
  HomeViewModelImpl({required super.ebookNetwork});

  @override
  Future<void> getBooks() async {
    value.ebooks = await ebookNetwork.getEbooks();

    notifyListeners();
  }

  @override
  void removeFavoriteBook({required int id}) {
    value.favoriteEbooks.removeWhere((element) => element.id == id);

    notifyListeners();
  }

  @override
  void favoriteBook({required Ebook ebook}) async {
    final result = isFavorite(id: ebook.id);

    if (result == true) {
      removeFavoriteBook(id: ebook.id);
    } else {
      value.favoriteEbooks.add(ebook);
    }

    notifyListeners();
  }

  @override
  bool isFavorite({required int id}) {
    return value.favoriteEbooks.where((element) => element.id == id).isNotEmpty;
  }
}

abstract class HomeViewModel extends EmitNotifier<HomeState> {
  final EbookNetwork ebookNetwork;

  HomeViewModel({
    required this.ebookNetwork,
  }) : super(HomeState(ebooks: [], favoriteEbooks: []));

  Future<void> getBooks();
  void favoriteBook({required Ebook ebook});
  void removeFavoriteBook({required int id});
  bool isFavorite({required int id});

  List<Ebook> getFavoriteBooks() {
    return value.favoriteEbooks;
  }
}
