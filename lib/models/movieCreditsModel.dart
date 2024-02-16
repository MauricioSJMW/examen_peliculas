// ignore_for_file: unnecessary_null_comparison

class MovieCredits {
  late int id;
  late List<Cast> cast;
  late List<Crew> crew;

  MovieCredits({required this.id, required this.cast, required this.crew});

  MovieCredits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cast'] != null) {
      cast = <Cast>[];
      json['cast'].forEach((v) {
        cast.add( Cast.fromJson(v));
      });
    }
    if (json['crew'] != null) {
      crew = <Crew>[];
      json['crew'].forEach((v) {
        crew.add( Crew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    if (cast != null) {
      data['cast'] = cast.map((v) => v.toJson()).toList();
    }
    if (crew != null) {
      data['crew'] = crew.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cast {
  late int castId;
  late String character;
  late String creditId;
  late int gender;
  late int id;
  late String name;
  late int order;
  late String profilePath;

  Cast(
      {required this.castId,
      required this.character,
      required this.creditId,
      required this.gender,
      required this.id,
      required this.name,
      required this.order,
      required this.profilePath});

  Cast.fromJson(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cast_id'] = castId;
    data['character'] = character;
    data['credit_id'] = creditId;
    data['gender'] = gender;
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    data['profile_path'] = profilePath;
    return data;
  }
}

class Crew {
  late String creditId;
  late String department;
  late int gender;
  late int id;
  late String job;
  late String name;
  late String profilePath;

  Crew(
      {required this.creditId,
      required this.department,
      required this.gender,
      required this.id,
      required this.job,
      required this.name,
      required this.profilePath});

  Crew.fromJson(Map<String, dynamic> json) {
    creditId = json['credit_id'];
    department = json['department'];
    gender = json['gender'];
    id = json['id'];
    job = json['job'];
    name = json['name'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['credit_id'] = creditId;
    data['department'] = department;
    data['gender'] = gender;
    data['id'] = id;
    data['job'] = job;
    data['name'] = name;
    data['profile_path'] = profilePath;
    return data;
  }
}