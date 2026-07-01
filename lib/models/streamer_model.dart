class StreamerModel {
  final String id;
  final String name;
  final String imageUrl;
  final String countryFlagUrl;
  final String viewerCount;

  StreamerModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.countryFlagUrl,
    required this.viewerCount,
  });


  factory StreamerModel.fromJson(Map<String, dynamic> json) {
    return StreamerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      countryFlagUrl: json['countryFlagUrl'] ?? '',
      viewerCount: json['viewerCount'] ?? '0',
    );
  }
}
