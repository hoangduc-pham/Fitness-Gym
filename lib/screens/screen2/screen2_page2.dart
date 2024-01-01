import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item.dart';

class Screen2Page2 extends StatefulWidget {
  @override
  _Screen2Page2 createState() => _Screen2Page2();
}

class _Screen2Page2 extends State<Screen2Page2> with SingleTickerProviderStateMixin {
  late TabController _tabController1;
  TextEditingController capacityController1 = TextEditingController();
  int maxcalotieuhao2 = 0;
  int maxcalotieuhao3 = 0;
  int maxcalotieuhao4 = 0;
  int maxcalotieuhao5 = 0;
  int maxcalotieuhao6 = 0;
  int maxcalotieuhao7 = 0;
  List<ItemScreen2> selectedItems2 = [];
  List<ItemScreen2> selectedItems3 = [];
  List<ItemScreen2> selectedItems4 = [];
  List<ItemScreen2> selectedItems5 = [];
  List<ItemScreen2> selectedItems6 = [];
  List<ItemScreen2> selectedItems7 = [];
  List<ItemScreen2> itemList1 = [];
  late List<List<int>> dp;

  @override
  void initState() {
    super.initState();
    _tabController1 = TabController(length: 2, vsync: this);
    _loaditemListlichtap();
  }

  @override
  void dispose() {
    _tabController1.dispose();
    _saveitemList1();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9, // Định hình tỷ lệ giữa chiều rộng và chiều cao
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    content: Container(
                  constraints: BoxConstraints(maxHeight: 150),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thời gian bạn dành để tập luyện hôm nay(phút):',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextFormField(
                        controller: capacityController1,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Nhập thời gian',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      if (index == 0)
                        ElevatedButton(
                          onPressed: () {
                            calculateAndSetKnapsack(2); // Gọi hàm tính toán cho buổi 2
                          },
                          child: Text('Xác nhận'),
                        ),
                      if (index == 1)
                        ElevatedButton(
                          onPressed: () {
                            calculateAndSetKnapsack(3); // Gọi hàm tính toán cho buổi 2
                          },
                          child: Text('Xác nhận'),
                        ),
                      if (index == 2)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            calculateAndSetKnapsack(4); // Gọi hàm tính toán cho buổi 2
                          },
                          child: Text('Xác nhận'),
                        ),
                      if (index == 3)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            calculateAndSetKnapsack(5); // Gọi hàm tính toán cho buổi 2
                          },
                          child: Text('Xác nhận'),
                        ),
                      if (index == 4)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            calculateAndSetKnapsack(6); // Gọi hàm tính toán cho buổi 2
                          },
                          child: Text('Xác nhận'),
                        ),
                      if (index == 5)
                        ElevatedButton(
                          onPressed: () {
                            calculateAndSetKnapsack(7); // Gọi hàm tính toán cho buổi 2
                          },
                          child: Text('Xác nhận'),
                        ),
                    ],
                  ),
                )); // Hiển thị thông tin container
              },
            );
          },
          child:Container(
            margin: EdgeInsets.all(9.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.indigo,
                  Colors.cyan, // Thay đổi màu theo nhu cầu của bạn
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Thứ ${index + 2}',
                  style: TextStyle(
                    color: Colors.yellow, // Thay đổi màu sắc tùy thuộc vào sự lựa chọn của bạn
                    fontSize: 20.0, // Tăng kích thước văn bản
                    fontWeight: FontWeight.bold, // In đậm văn bản
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),

                Text(
                  'Tổng lượng Calo tiêu hao: ',
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
                // Chỉ hiển thị maxcalotieuhao của ô đầu tiên
                if (index == 0)
                  Text(
                    '$maxcalotieuhao2',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                if (index == 1)
                  Text(
                    '$maxcalotieuhao3',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                if (index == 2)
                  Text(
                    '$maxcalotieuhao4',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                if (index == 3)
                  Text(
                    '$maxcalotieuhao5',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                if (index == 4)
                  Text(
                    '$maxcalotieuhao6',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                if (index == 5)
                  Text(
                    '$maxcalotieuhao7',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                Text('Danh sách bài tập :',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                // Chỉ hiển thị maxcalotieuhao của ô đầu tiên
                Expanded(
                  child: ListView.builder(
                    itemExtent: 27.0,
                    itemCount: index == 0
                        ? selectedItems2.length
                        : (index == 1
                            ? selectedItems3.length
                            : (index == 2
                                ? selectedItems4.length
                                : (index == 3
                                    ? selectedItems5.length
                                    : (index == 4
                                        ? selectedItems6.length
                                        : (index == 5 ? selectedItems7.length : 0))))),
                    itemBuilder: (context, ItemIndex) {
                      return ListTile(
                        title: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  index == 0
                                      ? '${selectedItems2[ItemIndex].namebaitap}'
                                      : (index == 1
                                          ? '${selectedItems3[ItemIndex].namebaitap}'
                                          : (index == 2
                                              ? '${selectedItems4[ItemIndex].namebaitap}'
                                              : (index == 3
                                                  ? '${selectedItems5[ItemIndex].namebaitap}'
                                                  : (index == 4
                                                      ? '${selectedItems6[ItemIndex].namebaitap}'
                                                      : (index == 5
                                                          ? '${selectedItems7[ItemIndex].namebaitap}'
                                                          : ''))))),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  index == 0
                                      ? '${selectedItems2[ItemIndex].sophut} phút'
                                      : (index == 1
                                          ? '${selectedItems3[ItemIndex].sophut} phút'
                                          : (index == 2
                                              ? '${selectedItems4[ItemIndex].sophut} phút'
                                              : (index == 3
                                                  ? '${selectedItems5[ItemIndex].sophut} phút'
                                                  : (index == 4
                                                      ? '${selectedItems6[ItemIndex].sophut} phút'
                                                      : (index == 5
                                                          ? '${selectedItems7[ItemIndex].sophut} phút'
                                                          : ''))))),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
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
          ),
        );
      },
    );
  }

  void calculateAndSetKnapsack(int index) {
    int capacity = int.tryParse(capacityController1.text) ?? 0;
    setState(() {
      dp = calculateDP(capacity, itemList1);
      switch (index) {
        case 2:
          maxcalotieuhao2 = _knapsack(capacity, itemList1);
          selectedItems2 = getselectedItems1(dp, capacity, itemList1);
          break;
        case 3:
          maxcalotieuhao3 = _knapsack(capacity, itemList1);
          selectedItems3 = getselectedItems1(dp, capacity, itemList1);
          break;
        case 4:
          maxcalotieuhao4 = _knapsack(capacity, itemList1);
          selectedItems4 = getselectedItems1(dp, capacity, itemList1);
          break;
        case 5:
          maxcalotieuhao5 = _knapsack(capacity, itemList1);
          selectedItems5 = getselectedItems1(dp, capacity, itemList1);
          break;
        case 6:
          maxcalotieuhao6 = _knapsack(capacity, itemList1);
          selectedItems6 = getselectedItems1(dp, capacity, itemList1);
          break;
        case 7:
          maxcalotieuhao7 = _knapsack(capacity, itemList1);
          selectedItems7 = getselectedItems1(dp, capacity, itemList1);
          break;
        default:
          break;
      }
    });
  }

  Future<void> _saveitemList1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemList1Json =
        itemList1.map((item) => jsonEncode(item.toMap())).toList();
    prefs.setStringList('itemList1', itemList1Json);
  }

  Future<void> _loaditemListlichtap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? itemList1Json = prefs.getStringList('itemList1');

    if (itemList1Json != null) {
      setState(() {
        itemList1 = itemList1Json.map((itemJson) {
          return ItemScreen2.fromMap(jsonDecode(itemJson));
        }).toList();
      });
    }
  }

  List<ItemScreen2> getselectedItems1(
      List<List<int>> dp, int capacity, List<ItemScreen2> items) {
    List<ItemScreen2> result = [];
    int i = items.length;
    int w = capacity;

    while (i > 0 && w > 0) {
      if (dp[i][w] != dp[i - 1][w]) {
        result.add(items[i - 1]);
        w -= items[i - 1].sophut;
      }
      i--;
    }

    return result;
  }

  List<List<int>> calculateDP(int capacity, List<ItemScreen2> items) {
    List<List<int>> dp =
        List.generate(items.length + 1, (i) => List.filled(capacity + 1, 0));

    for (var i = 1; i <= items.length; i++) {
      for (var j = 0; j <= capacity; j++) {
        if (items[i - 1].sophut <= j) {
          dp[i][j] = max(dp[i - 1][j],
              dp[i - 1][j - items[i - 1].sophut] + items[i - 1].calotieuhao);
        } else {
          dp[i][j] = dp[i - 1][j];
        }
      }
    }

    return dp;
  }

  int _knapsack(int capacity, List<ItemScreen2> items) {
    List<List<int>> dp =
        List.generate(items.length + 1, (i) => List.filled(capacity + 1, 0));

    for (var i = 1; i <= items.length; i++) {
      for (var j = 0; j <= capacity; j++) {
        if (items[i - 1].sophut <= j) {
          dp[i][j] = max(dp[i - 1][j],
              dp[i - 1][j - items[i - 1].sophut] + items[i - 1].calotieuhao);
        } else {
          dp[i][j] = dp[i - 1][j];
        }
      }
    }

    return dp[items.length][capacity];
  }
}
