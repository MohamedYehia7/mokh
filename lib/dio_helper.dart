import 'package:dio/dio.dart';
import 'package:mokh/product.dart';
import 'package:mokh/unit.dart';

class DioHelper {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://appydev-001-site2.atempurl.com/'));

  Future<List<Product>> fetchProduct() async {
    final response = await _dio.get('InvoiceDetail');
    return (response.data as List).map((json) => Product.fromJson(json)).toList();
  }

  Future<void> saveProduct(Product product) async {
    await _dio.post('InvoiceDetail', data: product.toJson());
  }

  Future<void> updateProduct(Product product) async {
    await _dio.put('InvoiceDetail/${product.lineNo}', data: product.toJson());
  }

  Future<void> deleteProduct(int lineNo) async {
    await _dio.delete('InvoiceDetail/$lineNo');
  }

  Future<List<Unit>> fetchUnits() async {
    final response = await _dio.get('Unit');
    return (response.data as List).map((json) => Unit.fromJson(json)).toList();
  }
}

