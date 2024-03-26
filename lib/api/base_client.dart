import 'dart:convert';
import 'dart:ffi';
import 'package:aws_flutter/model/category.dart';
import 'package:aws_flutter/model/login_model.dart';
import 'package:aws_flutter/model/order.dart';
import 'package:http/http.dart' as http;
import 'package:aws_flutter/model/art_work.dart';

const String baseUrl = 'https://127.0.0.1:7178/api';

class BaseClient {
  var client = http.Client();

  //Fetch Account
  Future<LoginModel> login(String email, String password) async {
    final apiUrl = 'http://aws-prn.somee.com/api/Auth/SignIn';
    final headers = <String, String> {
      'Content-Type': 'application/json',
    };

    final loginData = {
      'email': email,
      'password': password
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(loginData),
    );

    if(response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      return LoginModel.empty();
    }
  }

  //Fetch Api ArtWork
  Future<List<ArtWork>> fetchArtWorks() async {
    var response =
        await http.get(
          Uri.parse('http://aws-prn.somee.com/api/ArtWork/GetAll')
        );
    if(response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => ArtWork.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<ArtWork> fetchArtWorkById(String id) async {
    var response =
    await http.get(
        Uri.parse('http://aws-prn.somee.com/api/ArtWork/GetById?id=$id')
    );
    if(response.statusCode == 200) {
      return ArtWork.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<http.Response> createArtWork({
    required String userAccountId,
    required String categoryId,
    required String name,
    required String description,
    required double price,
    required String imageUrl
}) async {
    final apiUrl = 'http://aws-prn.somee.com/api/ArtWork/Add';
    final headers = <String, String> {
      'Content-Type': 'application/json',
    };

    final artworkData = {
      'userAccountId': userAccountId,
      'userOwnerId': userAccountId,
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(artworkData),
    );

    if (response.statusCode == 200) {
      // Xử lý kết quả thành công
      print('Đã tạo artwork thành công');
      return response;
    } else {
      // Xử lý lỗi hoặc trạng thái khác
      print('Lỗi khi tạo artwork: ${response.statusCode}');
      print('Nội dung lỗi: ${response.body}');
      return response;
    }
}

  //Fetch Api Category
  Future<List<Category>> fetchCategories() async {
    var response =
    await http.get(
        Uri.parse('http://aws-prn.somee.com/api/Category/GetAll')
    );
    if(response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  //fetch api order
  Future<http.Response> createOrder({
    required Order order
  }) async {
    final apiUrl = 'http://aws-prn.somee.com/api/Order/Add';
    final headers = <String, String> {
      'Content-Type': 'application/json',
    };

    final orderData = {
      'buyerAccountId': order.buyerAccountId,
      'ownerAccountId': order.ownerAccountId,
      'artWorkID': order.artWorkId,
      'status': order.status,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 200) {
      // Xử lý kết quả thành công
      print('Đã tạo order thành công');
      return response;
    } else {
      // Xử lý lỗi hoặc trạng thái khác
      print('Lỗi khi tạo order: ${response.statusCode}');
      print('Nội dung lỗi: ${response.body}');
      return response;
    }
  }
}