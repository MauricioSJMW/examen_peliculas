// ignore_for_file: unnecessary_new

class Movie {
 late List<Results> results;
 late int page;
 late int totalResults;
 late Dates dates;
 late int totalPages;

  Movie(
      {required this.results,
        required this.page,
        required this.totalResults,
        required this.dates,
        required this.totalPages});

  Movie.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results =  <Results>[];
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
    page = json['page'];
    totalResults = json['total_results'];
    dates = (json['dates'] != null ? new Dates.fromJson(json['dates']) : null)!;
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    if (this.dates != null) {
      data['dates'] = this.dates.toJson();
    }
    data['total_pages'] = this.totalPages;
    return data;
  }
}

class Results {
  late int voteCount;
  late int id;
 late  bool video;
  late double voteAverage;
  late String title;
  late double popularity;
  late String posterPath;
  late String originalLanguage;
  late String originalTitle;
  late List<int> genreIds;
  late String backdropPath;
 late  bool adult;
 late  String overview;
  late String releaseDate;
  late int heroTag;

  Results(
      {required this.voteCount,
        required this.id,
        required this.video,
        required this.voteAverage,
        required this.title,
        required this.popularity,
       required this.posterPath,
       required this.originalLanguage,
       required this.originalTitle,
       required this.genreIds,
       required this.backdropPath,
       required this.adult,
       required this.overview,
       required this.releaseDate});

  Results.fromJson(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    //voteAverage = json['vote_average'];
    title = json['title'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vote_count'] = this.voteCount;
    data['id'] = this.id;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['title'] = this.title;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['backdrop_path'] = this.backdropPath;
    data['adult'] = this.adult;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }
}

class Dates {
 late  String maximum;
 late String minimum;

  Dates({required this.maximum, required this.minimum});

  Dates.fromJson(Map<String, dynamic> json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maximum'] = this.maximum;
    data['minimum'] = this.minimum;
    return data;
  }
}