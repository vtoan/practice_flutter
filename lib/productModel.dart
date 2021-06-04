import 'dart:async';

class Product {
  final int id;
  final String p0;
  final String p1;
  final String p2;
  final String p3;
  final String p4;
  final String p5;
  final String p6;

  Product(
      {this.id = 0,
      this.p0 = "",
      this.p1 = "",
      this.p2 = "",
      this.p3 = "",
      this.p4 = "",
      this.p5 = "",
      this.p6 = ""});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['Id'] ?? "",
      p0: json['p0'] ?? "",
      p1: json['p1'] ?? "",
      p2: json['p2'] ?? "",
      p3: json['p3'] ?? "",
      p4: json['p4'] ?? "",
      p5: json['p5'] ?? "",
      p6: json['p6'] ?? "",
    );
  }
}
