import 'dart:convert';

import 'package:my_app/productModel.dart';

import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Product>> fetchProduct() async {
    final response = await http.get(Uri.parse(
        'http://api.phanmemquocbao.com/api/Doituong/getobjectsall?tokenget=lethibaotran'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Product> products = [];
      data.forEach((element) {
        var p = Product.fromJson(element);
        products.add(p);
      });
      return products;
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<http.Response> createProduct(Product product) {
    return http.get(Uri.parse(
        'http://api.phanmemquocbao.com/api/Doituong/InsertObjects?p0=${product.p0}&id=${product.id}&p1=${product.p1}&p2=${product.p2}&p3=${product.p3}&p4=${product.p4}&p5=${product.p5}&p6=${product.p6}&tokenin=lethibaotran'));
  }

  static Future<http.Response> updateProduct(Product product) {
    return http.get(Uri.parse(
        'http://api.phanmemquocbao.com/api/Doituong/updateObjects?id=${product.id}&p0=${product.p0}&p1=${product.p1}&p2=${product.p2}&p3=${product.p3}&p4=${product.p4}&p5=${product.p5}&p6=${product.p6}&tokenup=lethibaotran'));
  }

  static Future<http.Response> deleteProduct(int productId) {
    return http.get(Uri.parse(
        'http://api.phanmemquocbao.com/api/Doituong/deleteObject?id=${productId}&tokende=lethibaotran'));
  }
}
