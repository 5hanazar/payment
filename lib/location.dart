class LocationDto {
  final String imageUrl;
  final String name;
  final String country;

  LocationDto(
      {required this.imageUrl,
        required this.name,
        required this.country});

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
        imageUrl: json['imageUrl'],
        name: json['name'],
        country: json['country']);
  }
}