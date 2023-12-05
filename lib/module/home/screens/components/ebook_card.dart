import 'package:flutter/material.dart';

import '../../../../consttants.dart';
import '../../models/ebook.dart';

class EbookCard extends StatelessWidget {
  const EbookCard({
    super.key,
    required this.ebook,
    required this.onPress,
    this.isFavorite = false,
  });

  final Ebook ebook;
  final Function() onPress;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: 400,
        decoration: BoxDecoration(
          color: colorTwo,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 10),
              blurRadius: 33,
              color: oShadowColor,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.network(
                      ebook.coverUrl,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 4,
                    child: IconButton(
                      onPressed: onPress,
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        size: 35,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              ebook.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium! //
                  .copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              ebook.author,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
