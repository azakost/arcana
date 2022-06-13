import 'package:intl/intl.dart';

String parseTime(String datetime, {bool short = false}) {
  return DateFormat(short ? 'dd.MM' : 'dd.MM.yyyy').format(DateTime.parse(datetime));
}

int calcAge(String datetime) {
  return (DateTime.now().difference(DateTime.parse(datetime)).inDays / 365).round();
}

int calcAgeReverse(String datetime) {
  final arr = datetime.split('.');
  return (DateTime.now().difference(DateTime.parse(arr[2] + '-' + arr[1] + '-' + arr[0])).inDays / 365).round();
}

class Account {
  Account({
    this.id = 0,
    this.phone = '',
    this.email = '',
    this.currentUserId = 0,
    this.relatives = const [],
  });

  int id;
  String phone;
  String email;
  int currentUserId;
  List<User> relatives;

  factory Account.fromJson(dynamic json) {
    return Account(
      id: json["id"] ?? 0,
      phone: json["phone"] ?? '',
      email: json["email"] ?? '',
      currentUserId: json["current_user_id"] ?? 0,
      relatives: json["relatives"] == null ? [] : List<User>.from(json["relatives"].map((x) => User.fromJson(x))),
    );
  }
}

class User {
  User({
    this.id = 0,
    this.name = '',
    this.gender = false,
    this.height = 0,
    this.weight = 0,
    this.age = 0,
    this.birthday = '',
    this.recomendedMarkers = const [],
    this.recomendedAnalyzes = const [],
    this.passedMarkers = const [],
    this.passedAnalyzes = const [],
    this.recomendedProfilesIds = const [],
    this.chosenProfilesIds = const [],
  });

  int id;
  String name;
  bool gender;
  int height;
  int weight;
  int age;
  String birthday;
  List<Recomended> recomendedMarkers;
  List<Recomended> recomendedAnalyzes;
  List<PassedMarker> passedMarkers;
  List<PassedAnalyze> passedAnalyzes;
  List<int> recomendedProfilesIds;
  List<int> chosenProfilesIds;

  factory User.fromJson(dynamic json) {
    return User(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      gender: json["gender"] ?? false,
      height: json["height"] ?? 0,
      weight: json["weight"] ?? 0,
      age: json["birthday"] == null ? 0 : calcAge(json["birthday"]),
      birthday: json["birthday"] == null ? '' : parseTime(json["birthday"]),
      recomendedMarkers: json["recomended_markers"] == null ? [] : List<Recomended>.from(json["recomended_markers"].map((x) => Recomended.fromJson(x))),
      recomendedAnalyzes: json["recomended_analyzes"] == null ? [] : List<Recomended>.from(json["recomended_analyzes"].map((x) => Recomended.fromJson(x))),
      passedMarkers: json["passed_markers"] == null ? [] : List<PassedMarker>.from(json["passed_markers"].map((x) => PassedMarker.fromJson(x))),
      passedAnalyzes: json["passed_analyzes"] == null ? [] : List<PassedAnalyze>.from(json["passed_analyzes"].map((x) => PassedAnalyze.fromJson(x))),
      recomendedProfilesIds: json["recomended_profiles_ids"] == null ? [] : List<int>.from(json["recomended_profiles_ids"].map((x) => x)),
      chosenProfilesIds: json["chosen_profiles_ids"] == null ? [] : List<int>.from(json["chosen_profiles_ids"].map((x) => x)),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "gender": gender,
      "height": height,
      "weight": weight,
      "birthday": birthday,
    };
  }
}

class PassedAnalyze {
  PassedAnalyze({
    this.id = 0,
    this.name = '',
    this.passDate = '',
    this.passedMarkers = const [],
  });

  int id;
  String name;
  String passDate;
  List<PassedMarker> passedMarkers;

  factory PassedAnalyze.fromJson(dynamic json) {
    return PassedAnalyze(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      passDate: json["pass_date"] == null ? '' : parseTime(json["pass_date"]),
      passedMarkers: json["passed_markers"] == null ? [] : List<PassedMarker>.from(json["passed_markers"].map((x) => PassedMarker.fromJson(x))),
    );
  }
}

class PassedMarker {
  PassedMarker({
    this.id = 0,
    this.name = '',
    this.profilesIds = const [],
    this.passDate = '',
    this.value = 0,
    this.trend = const [],
  });

  int id;
  String name;
  List<int> profilesIds;
  String passDate;
  int value;
  List<Trend> trend;

  factory PassedMarker.fromJson(dynamic json) {
    return PassedMarker(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      profilesIds: json["profiles_ids"] == null ? [] : List<int>.from(json["profiles_ids"].map((x) => x)),
      passDate: json["pass_date"] == null ? '' : parseTime(json["pass_date"]),
      value: json["value"] ?? 0,
      trend: json["trend"] == null ? [] : List<Trend>.from(json["trend"].map((x) => Trend.fromJson(x))),
    );
  }
}

class Trend {
  Trend({
    this.passDate = '',
    this.value = 0,
  });

  String passDate;
  int value;

  factory Trend.fromJson(dynamic json) {
    return Trend(
      passDate: json["pass_date"] == null ? '' : parseTime(json["pass_date"]),
      value: json["value"] ?? 0,
    );
  }
}

class Recomended {
  Recomended({
    this.id = 0,
    this.name = '',
    this.dueDate = '',
  });

  int id;
  String name;
  String dueDate;

  factory Recomended.fromJson(dynamic json) {
    return Recomended(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      dueDate: json["due_date"] == null ? '' : parseTime(json["due_date"]),
    );
  }
}
