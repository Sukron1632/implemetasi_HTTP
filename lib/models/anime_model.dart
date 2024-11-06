class Anime{
  final int id;
  final String name;
  final String imageUrl;


Anime({
  required this.id,
  required this.name,
  required this.imageUrl,

});

factory Anime.fromJson(Map<String, dynamic> json){
  return Anime(
    id: json['id'] ?? 0,
    name: json['name'] ?? 0,
    imageUrl: (json['images'] != null && json['images'].isNotEmpty)
    ? json['images'] [0] : 'https://placehold.co/600x400');
}
}

