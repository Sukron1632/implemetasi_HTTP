import 'package:flutter/material.dart';
import 'package:latihan/detail/anime_detail.dart';
import 'package:latihan/models/anime_model.dart';
import 'package:latihan/presenters/anime_presenter.dart';

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({super.key});

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen>
    implements AnimeView {
  late AnimePresenter _presenter;
  bool _isLoading = false;
  List<Anime> _animeList = [];
  String? _erorMessage;
  String _currentEndpoint = 'akatsuki';

  @override
  void initState() {
    super.initState();
    _presenter = AnimePresenter(this);
    _presenter.loadAnimeData(_currentEndpoint);
  }

  void _fetchData(String endpoint) {
    setState(() {
      _currentEndpoint = endpoint;
      _presenter.loadAnimeData(endpoint);
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showANimeList(List<Anime> animeList) {
    _animeList = animeList;
  }

  @override
  void showError(String message) {
    _erorMessage = message;
  }

  @override
  void showLoading() {
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anime List"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => _fetchData('akatsuki'),
                  child: const Text("Akatsuki")),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () => _fetchData('kara'),
                  child: const Text("Kara")),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () => _fetchData('characters'),
                  child: const Text("Karakter"))
            ],
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _erorMessage != null
                    ? Center(child: Text("Error : ${_erorMessage}"))
                    : ListView.builder(
                        itemCount: _animeList.length,
                        itemBuilder: (context, index) {
                          final anime = _animeList[index];
                          return ListTile(
                            leading: anime.imageUrl.isNotEmpty
                                ? Image.network(anime.imageUrl)
                                : Image.network('https://placehold.co/600x400'),
                            title: Text(anime.name),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                      id: anime.id, endpoint: _currentEndpoint),
                                ),
                              );
                            },
                          );
                        },
                      ),
          )
        ],
      ),
    );
  }
}
