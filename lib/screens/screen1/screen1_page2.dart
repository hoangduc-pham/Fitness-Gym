import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/extension_format_number.dart';
import 'item.dart';

class BuildResultTab extends StatefulWidget {
  @override
  _BuildResultTab createState() => _BuildResultTab();
}

class _BuildResultTab extends State<BuildResultTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController capacityController = TextEditingController();
  int maxcalo = 0;
  List<Item> selectedItems = [];
  List<Item> itemList = [];
  late List<List<int>> dp;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadItemList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _saveItemList();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Số tiền bạn chi cho bữa ăn hôm nay:',
                  style: TextStyle(color: Colors.black),
                ),
                TextFormField(
                  controller: capacityController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Nhập số tiền',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
              await Future.delayed(Duration(seconds: 2));
              _calculateKnapsack();
          },
            child: Text('Bắt đầu tính'),
          ),
          SizedBox(height: 20.0),
          Text(
            'Tổng lượng Calo: $maxcalo',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 23.0,
              backgroundColor: Colors.yellow,
            ),
          ),

          SizedBox(height: 10.0),
          Text('Danh sách thực phẩm tối ưu:',
          style: TextStyle(color: Colors.white)),
          Expanded(
            child: ListView.builder(
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${selectedItems[index].name}',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Giá tiền: ${(selectedItems[index].price).formatNumber()} đ\nLượng Calo: ${selectedItems[index].calo}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  void _calculateKnapsack() {
    int capacity = int.tryParse(capacityController.text) ?? 0;
    setState(() {
      dp = calculateDP(capacity, itemList);
      maxcalo = _knapsack(capacity, itemList);
      selectedItems = getSelectedItems(dp, capacity, itemList);
    });
  }

  Future<void> _saveItemList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemListJson = itemList.map((item) => jsonEncode(item.toMap())).toList();
    prefs.setStringList('itemList', itemListJson);
  }

  Future<void> _loadItemList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? itemListJson = prefs.getStringList('itemList');

    if (itemListJson != null) {
      setState(() {
        itemList = itemListJson.map((itemJson) {
          return Item.fromMap(jsonDecode(itemJson));
        }).toList();
      });
    }
  }
  List<Item> getSelectedItems(List<List<int>> dp, int capacity, List<Item> items) {
    List<Item> result = [];
    int i = items.length;
    int w = capacity;

    while (i > 0 && w > 0) {
      if (dp[i][w] != dp[i - 1][w]) {
        result.add(items[i - 1]);
        w -= items[i - 1].price;
      }
      i--;
    }

    return result;
  }
  List<List<int>> calculateDP(int capacity, List<Item> items) {
    List<List<int>> dp = List.generate(items.length + 1, (i) => List.filled(capacity + 1, 0));

    for (var i = 1; i <= items.length; i++) {
      for (var j = 0; j <= capacity; j++) {
        if (items[i - 1].price <= j) {
          dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - items[i - 1].price] + items[i - 1].calo);
        } else {
          dp[i][j] = dp[i - 1][j];
        }
      }
    }

    return dp;
  }
  int _knapsack(int capacity, List<Item> items) {
    List<List<int>> dp = List.generate(items.length + 1, (i) => List.filled(capacity + 1, 0));

    for (var i = 1; i <= items.length; i++) {
      for (var j = 0; j <= capacity; j++) {
        if (items[i - 1].price <= j) {
          dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - items[i - 1].price] + items[i - 1].calo);
        } else {
          dp[i][j] = dp[i - 1][j];
        }
      }
    }

    return dp[items.length][capacity];
  }
}