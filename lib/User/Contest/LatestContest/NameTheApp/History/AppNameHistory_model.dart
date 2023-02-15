class AppHistoryModel {
  AppHistoryModel({
    required this.count,
   required this.data,
    required this.pagination,
  });

  int count;
  List<Datum> data;
  Pagination pagination;

  factory AppHistoryModel.fromJson(Map<String, dynamic> json) => AppHistoryModel(
    count: json["count"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Datum {
  Datum({
    required this.date,
    required this.id,
    required this.name,
    required this.url,
    required this.user,
  });

  String date;
  int id;
  String name;
  String url;
  String user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["date"],
    id: json["id"],
    name: json["name"],
    url: json["url"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "id": id,
    "name": name,
    "url": url,
    "user": user,
  };
}

class Pagination {
  Pagination({
    required this.hasNext,
    required this.hasPrevious,
    required this.index,
    required this.limit,
  });

  bool hasNext;
  bool hasPrevious;
  int index;
  int limit;

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
