class ImageHistoryModel {
  ImageHistoryModel({
    required this.count,
    required this.data,
    required this.pagination,
  });

  int count;
  List<Datum> data;
  Pagination pagination;

  factory ImageHistoryModel.fromJson(Map<String, dynamic> json) => ImageHistoryModel(
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
    required this.url,
  });

  String date;
  int id;
  String url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["date"],
    id: json["id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "id": id,
    "url": url,
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
