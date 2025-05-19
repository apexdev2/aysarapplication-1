class Pagination {
  int? currentPage;
  int? from;
  int? lastPage;
  int? perPage;
  int? to;
  int? total;
  int? count;
  bool? hasNext;

  String? previousPageUrl;
  String? paginationName;

  Pagination(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.perPage,
      this.to,
      this.total,
      this.count,
      this.hasNext,
   
      this.previousPageUrl,
      this.paginationName});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
    count = json['count'];
    hasNext = json['has_next'];
    previousPageUrl = json['previous_page_url'];
    paginationName = json['pagination_name'];
  }


}