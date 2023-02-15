class PoemModel {
  PoemModel({
    this.count,
    this.data,
    this.pagination,
  });

  int? count;
  List<Datum>? data;
  Pagination? pagination;

  factory PoemModel.fromJson(Map<String, dynamic> json) => PoemModel(
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination!.toJson(),
      };
}

class Datum {
  Datum({
    required this.date,
    required this.name,
    required this.user,
    required this.title,
    required this.url,
  });

  String date;
  String name;
  String user;
  String title;
  String url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      date: json["date"],
      name: json["name"],
      user: json["user"],
      title: json["title"],
      url: json["url"]);

  Map<String, dynamic> toJson() => {
        "date": date,
        "name": name,
        "user": user,
        "title": title,
        "url": url,
      };
}

class Pagination {
  Pagination({
    this.hasNext,
    this.hasPrevious,
    this.index,
    this.limit,
  });

  bool? hasNext;
  bool? hasPrevious;
  int? index;
  int? limit;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        hasNext: json["has_next"],
        hasPrevious: json["has_previous"],
        index: json["index"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "has_next": hasNext,
        "has_previous": hasPrevious,
        "index": index,
        "limit": limit,
      };
}
