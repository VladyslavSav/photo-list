class Photo {
  final String id;
  final String url;

  Photo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'];
}
