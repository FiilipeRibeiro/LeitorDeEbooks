import 'package:flutter/material.dart';

import '../../../consttants.dart';
import '../../home/feature/di/di.dart';
import '../../home/models/ebook.dart';
import '../../home/screens/components/ebook_card.dart';
import '../../home/screens/home_screen.dart';
import '../widgets/favorite_button.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = homeViewModelBuilder;
    viewModel.getBooks();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: colorOne,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SizedBox(
                child: FavoriteButton(
                  text: 'Go back list',
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ValueListenableBuilder(
                  valueListenable: viewModel,
                  builder: (context, value, child) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 400,
                    ),
                    itemCount: viewModel.getFavoriteBooks().length,
                    itemBuilder: (context, index) {
                      final List<Ebook> favoriteBooks =
                          viewModel.getFavoriteBooks();
                      return EbookCard(
                        ebook: favoriteBooks[index],
                        onPress: () =>
                            viewModel.favoriteBook(ebook: favoriteBooks[index]),
                        isFavorite:
                            viewModel.isFavorite(id: favoriteBooks[index].id),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
