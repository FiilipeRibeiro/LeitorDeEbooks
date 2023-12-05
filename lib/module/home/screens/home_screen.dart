import 'package:flutter/material.dart';
import 'package:leitor_de_ebooks/module/home/screens/components/epub_viewer.dart';

import '../../../consttants.dart';
import '../../favorite/screen/favorite_screen.dart';
import '../../favorite/widgets/favorite_button.dart';
import '../feature/di/di.dart';
import 'components/ebook_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = homeViewModelBuilder;
    viewModel.getBooks();

    var size = MediaQuery.of(context).size;
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
                height: size.height * 0.12,
                child: FavoriteButton(
                  text: 'Favorite',
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoriteScreen(),
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
                    itemCount: value.ebooks.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EpubViewer(
                                ebookUrl: value.ebooks[index].downloadUrl,
                              ),
                            ),
                          );
                        },
                        child: EbookCard(
                          ebook: value.ebooks[index],
                          onPress: () => viewModel.favoriteBook(
                            ebook: value.ebooks[index],
                          ),
                          isFavorite: viewModel.isFavorite(
                            id: value.ebooks[index].id,
                          ),
                        ),
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
