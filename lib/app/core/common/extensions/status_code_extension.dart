extension StatusCode on int? {
  static const int success = 200;
  static const int created = 201;

  bool get isSuccessCode => this == success || this == created;
}
