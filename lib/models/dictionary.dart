class Dictionary {
  Dictionary({
    this.hs = '',
    this.data = const Data(),
  });

  String hs;
  Data data;

  factory Dictionary.fromJson(Map<String, dynamic> json) => Dictionary(
        hs: json["hs"] ?? '',
        data: json["data"] == null ? Data() : Data.fromJson(json["data"]),
      );
}

class Data {
  const Data({
    this.markers = const [],
    this.analyzes = const [],
    this.profiles = const [],
  });

  final List<Marker> markers;
  final List<Analyze> analyzes;
  final List<Profile> profiles;

  factory Data.fromJson(dynamic json) {
    return Data(
      markers: json["markers"] == null ? [] : List<Marker>.from(json["markers"].map((x) => Marker.fromJson(x))),
      analyzes: json["analyzes"] == null ? [] : List<Analyze>.from(json["analyzes"].map((x) => Analyze.fromJson(x))),
      profiles: json["profiles"] == null ? [] : List<Profile>.from(json["profiles"].map((x) => Profile.fromJson(x))),
    );
  }
}

class Analyze {
  Analyze({
    this.id = 0,
    this.name = '',
    this.markers = const [],
  });

  int id;

  String name;
  List<Marker> markers;

  factory Analyze.fromJson(dynamic json) {
    return Analyze(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      markers: json["markers"] == null ? [] : List<Marker>.from(json["markers"].map((x) => Marker.fromJson(x))),
    );
  }
}

class Marker {
  Marker({
    this.id = 0,
    this.intervalDays = 0,
    this.name = '',
    this.note = '',
    this.spec = const Spec(),
    this.value = 0,
    this.unit = '',
  });

  int id;
  int intervalDays;
  String name;
  String note;
  Spec spec;
  int value;
  String unit;

  factory Marker.fromJson(dynamic json) {
    return Marker(
      id: json["id"] ?? 0,
      intervalDays: json["interval_days"] ?? 0,
      name: json["name"] ?? '',
      note: json["note"] ?? '',
      unit: json["unit"] ?? '',
      spec: json["spec"] == null ? Spec() : Spec.fromJson(json["spec"]),
    );
  }
}

class Spec {
  const Spec({
    this.female = const [],
    this.male = const [],
  });

  final List<Gender> female;
  final List<Gender> male;

  factory Spec.fromJson(dynamic json) {
    return Spec(
      female: json["female"] == null ? [] : List<Gender>.from(json["female"].map((x) => Gender.fromJson(x))),
      male: json["male"] == null ? [] : List<Gender>.from(json["male"].map((x) => Gender.fromJson(x))),
    );
  }
}

class Gender {
  Gender({
    this.maxAge = 0,
    this.maxValue = 0,
    this.minAge = 0,
    this.minValue = 0,
  });

  int maxAge;
  int maxValue;
  int minAge;
  int minValue;

  factory Gender.fromJson(dynamic json) {
    return Gender(
      maxAge: json["max_age"] ?? 0,
      maxValue: json["max_value"] ?? 0,
      minAge: json["min_age"] ?? 0,
      minValue: json["min_value"] ?? 0,
    );
  }
}

class Profile {
  Profile({
    this.id = 0,
    this.name = '',
    this.colors = const [],
    this.image = '',
    this.markersIds = const [],
    this.analyzesIds = const [],
  });

  int id;
  String name;
  List<String> colors;
  String image;
  List<int> markersIds;
  List<int> analyzesIds;

  factory Profile.fromJson(dynamic json) {
    return Profile(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      colors: json["colors"] == null ? [] : List<String>.from(json["colors"].map((x) => x)),
      image: json["image"] ?? '',
      markersIds: json["markers_ids"] == null ? [] : List<int>.from(json["markers_ids"].map((x) => x)),
      analyzesIds: json["analyzes_ids"] == null ? [] : List<int>.from(json["analyzes_ids"].map((x) => x)),
    );
  }
}
