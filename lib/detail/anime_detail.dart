import 'package:flutter/material.dart';
import 'package:latihan/presenters/anime_detail_presenter.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id, required this.endpoint});
  final int id;
  final String endpoint;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> implements AnimeDetailView {
  late AnimeDetailPresenter _presenter;
  bool _isLoading = true;
  Map<String, dynamic>? _detailData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _presenter = AnimeDetailPresenter(this);
    _presenter.loadDetailData(widget.endpoint, widget.id);
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showDetailData(Map<String, dynamic> detailData) {
    setState(() {
      _detailData = detailData;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Character Detail"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text("Error: $_errorMessage"))
              : _detailData != null
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            _detailData!['images'][0] ?? 'https://placehold.co/600x400',
                          ),
                          const SizedBox(height: 10),
                          Text("Name: ${_detailData!['name']}"),
                          Text("Clan: ${_detailData!['personal']['clan'] ?? 'Unknown'}"),
                          Text("Kekkei Genkai: ${_detailData!['personal']['kekkeiGenkai'] ?? 'None'}"),
                          Text("Affiliations: ${_detailData!['affiliations']?.join(', ') ?? 'None'}"),
                          Text("Rank: ${_detailData!['personal']['rank'] ?? 'N/A'}"),
                        ],
                      ),
                    )
                  : const Center(child: Text("No data available!")),
    );
  }
}
