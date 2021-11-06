import 'package:anilocator/repository/anime.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();

    final handleSearch = useProvider(animeProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Weebs'),
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: searchController,
                    decoration:
                        const InputDecoration(hintText: 'Enter image URL'),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      handleSearch.getAnime(searchController.text);
                    },
                    child: const Text('Search'),
                  )
                ],
              ),
            ),
            Expanded(
                child: useProvider(animeProvider).when(
                    error: (error, _) => Center(
                          child: Text(error.toString()),
                        ),
                    idle: () => const Center(
                          child: Text('Enter a valid image url'),
                        ),
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                    success: (value) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              Card(
                                  elevation: 2,
                                  child: Column(
                                    children: const <Widget>[
                                      ListTile(
                                        leading: Text('Title'),
                                        title: Text('somethins'),
                                      ),
                                      ListTile(
                                        leading: Text('Title'),
                                        title: Text('somethins'),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ));
  }
}
