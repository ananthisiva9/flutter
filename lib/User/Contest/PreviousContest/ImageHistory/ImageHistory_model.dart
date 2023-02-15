class ImageModel {
  ImageModel({
    this.count,
    this.data,
    this.pagination,
  });

  int? count;
  List<Datum>? data;
  Pagination? pagination;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
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
    this.date,
    this.url,
  });

  String? date;
  String? url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["date"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
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
