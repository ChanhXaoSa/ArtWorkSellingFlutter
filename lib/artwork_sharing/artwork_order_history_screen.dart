import 'dart:convert';

import 'package:aws_flutter/api/base_client.dart';
import 'package:aws_flutter/model/login_model.dart';
import 'package:aws_flutter/model/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ArtworkOrderHistoryScreen extends StatefulWidget {
  @override
  _ArtworkOrderHistoryScreenState createState() =>
      _ArtworkOrderHistoryScreenState();
}

class _ArtworkOrderHistoryScreenState extends State<ArtworkOrderHistoryScreen> {
  late Future<List<Order>> futureOrderList;
  late List<Order> orderList = [];

  late Future<Accinfo?> accInfoFuture;
  late Future<String?> tokenFuture;
  late Accinfo accinfo = Accinfo.empty();
  late String token = '';

  final storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<Accinfo?> getAccInfo() async {
    String? accinfoJsonString = await storage.read(key: 'accinfo');
    if (accinfoJsonString != null) {
      Map<String, dynamic> accinfoJson = json.decode(accinfoJsonString);
      Accinfo accinfo = Accinfo.fromJson(accinfoJson);
      return accinfo;
    }
    return null;
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  Future<void> setData() async {
    tokenFuture = getToken();
    tokenFuture.then((value) => {
          setState(() {
            token = value!;
          })
        });
    accInfoFuture = getAccInfo();
    accInfoFuture.then((value) => {
          setState(() {
            accinfo = value!;
          })
        });
    futureOrderList = BaseClient().fetchOrders();
    futureOrderList.then((value) => {
          for (var item in value)
            {
              if (item.buyerAccountId == accinfo.id)
                {
                  setState(() {
                    orderList.add(item);
                  })
                }
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          final order = orderList[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(order.artWork!.imageUrl),
                radius: 30.0,
              ),
              title: Text(
                order.artWork!.name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Status: ${getStatusName(order.status)}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: getStatusColor(order.status),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String getStatusName(int status) {
    switch (status) {
      case 0:
        return 'Cancel';
      case 1:
        return 'Pending';
      case 2:
        return 'Accepted';
      default:
        return 'Unknown';
    }
  }
  
  Color getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
