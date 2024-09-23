class FestivalModel {
  String festivalName;
  String description;
  String date;
  String region;
  String moral;
  String thumbnail;
  List<String> detailing;
  List<String> images;
  List<String> wishes;

  FestivalModel({
    required this.festivalName,
    required this.description,
    required this.date,
    required this.region,
    required this.moral,
    required this.thumbnail,
    required this.detailing,
    required this.images,
    required this.wishes,
  });

  factory FestivalModel.fromFestivalData({required Map<String, dynamic> data}) {
    return FestivalModel(
      festivalName: data['festivalName'],
      description: data['description'],
      date: data['date'],
      region: data['region'],
      moral: data['moral'],
      thumbnail: data['thumbnail'],
      detailing: data['detailing'],
      images: data['images'],
      wishes: data['wishes'],
    );
  }
}
