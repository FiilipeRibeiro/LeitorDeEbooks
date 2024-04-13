import 'package:estudando/src/controllers/home_controller.dart';
import 'package:estudando/src/repositories/dio/dio_client.dart';
import 'package:estudando/src/repositories/ebook_repository.dart';
import 'package:flutter/material.dart';

import 'epub_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tabsCount = 2;
  final controller = HomeController(EbookRepository(DioClient()));

  @override
  void initState() {
    super.initState();
    controller.fetchAllEbooks();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            backgroundColor: Colors.amber,
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 1;
            },
            scrolledUnderElevation: 4.0,
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.book,
                    size: 40,
                  ),
                  text: 'Books',
                ),
                Tab(
                  icon: Icon(
                    Icons.favorite,
                    size: 40,
                  ),
                  text: 'Favorites',
                )
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, widget) {
              return TabBarView(
                children: <Widget>[
                  ListView.builder(
                    itemCount: controller.ebooks.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ebook = controller.ebooks[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EpubViewerPage(
                                downloadUrl: ebook.download_url,
                                title: ebook.title,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                ebook.cover_url,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                ebook.title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                              ),
                              subtitle: Text(ebook.author),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    controller.toggleFavorite(ebook);
                                  });
                                },
                                icon: controller.isFavorite(ebook)
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 35,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                        size: 35,
                                      ),
                              ),
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: controller.favorites.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ebook = controller.favorites[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EpubViewerPage(
                                downloadUrl: ebook.download_url,
                                title: ebook.title,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                ebook.title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text(ebook.author),
                              leading: Image.network(ebook.cover_url),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    controller.removeFavorites(ebook);
                                  });
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
