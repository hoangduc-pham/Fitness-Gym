import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item.dart';
import 'screen2_page2.dart';


class Screen2 extends StatefulWidget {
  @override
  _Screen2 createState() => _Screen2();
}

class _Screen2 extends State<Screen2> with SingleTickerProviderStateMixin {
  late TabController _tabController1;
  TextEditingController itemnamebaitapController = TextEditingController();
  TextEditingController itemsophutController = TextEditingController();
  TextEditingController itemcalotieuhaoController = TextEditingController();
  List<ItemScreen2> itemList1 = [];

  @override
  void initState() {
    super.initState();
    _tabController1 = TabController(length: 2, vsync: this);
    _loaditemList11();
  }

  @override
  void dispose() {
    _tabController1.dispose();
    _saveitemList11();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.brown,
        title: Text('Sắp xếp lịch tập'),
        bottom: TabBar(
          indicatorColor: Colors.cyan,
          controller: _tabController1,
          tabs: [
            Tab(text: 'Thông tin bài tập'),
            Tab(text: 'Sắp xếp'),
          ],
        ),
      ),
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/lichtap2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          TabBarView(
            controller: _tabController1,
            children: [
              Screen2Page1(),
              Screen2Page2(),
            ],
          ),
        ],
      ),
    );
  }

  Widget Screen2Page1() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Expanded(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18.0),
              Row(
                children: [
                  Text(
                    'Danh sách bài tập:',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  GestureDetector(
                    onTap: _showAddItemBottomSheet,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: ListView.builder(
                  itemCount: itemList1.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0, // Độ dày của viền
                          ),
                          color: Colors.white.withOpacity(0.5), // Màu nền
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3), // Điều chỉnh độ đổ bóng
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(8.0), // Khoảng cách giữa viền và nội dung
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${itemList1[index].namebaitap}',
                              style: TextStyle(color: Colors.black),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1.0,
                              height: 8.0,
                            ),
                            Text(
                              'Thời gian: ${itemList1[index].calotieuhao} phút \nLượng Calo tiêu hao: ${itemList1[index].calotieuhao}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.delete_outline),
                        onPressed: () => _removeItem1(index),
                      ),
                    );

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddItemBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft:Radius.circular(15.0),topRight: Radius.circular(15.0)), // Điều chỉnh bo tròn ở đây
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Thêm bài tập', style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: itemnamebaitapController,
                  decoration: InputDecoration(
                    hintText: 'Tên',
                  ),
                ),
                TextFormField(
                  controller: itemsophutController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Thời gian',
                  ),
                ),
                TextFormField(
                  controller: itemcalotieuhaoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Lượng Calo tiêu hao',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _addItemToList1();
                    Navigator.pop(context);
                  },
                  child: Text('Thêm'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _loaditemList11() async {
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
  Future<void> _saveitemList11() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemList1Json = itemList1.map((item) => jsonEncode(item.toMap())).toList();
    prefs.setStringList('itemList1', itemList1Json);
  }
  void _addItemToList1() {
    String namebaitap = itemnamebaitapController.text;
    int sophut = int.tryParse(itemsophutController.text) ?? 0;
    int calotieuhao = int.tryParse(itemcalotieuhaoController.text) ?? 0;
    if (namebaitap.isNotEmpty && sophut > 0 && calotieuhao > 0) {
      setState(() {
        itemList1.add(ItemScreen2(namebaitap, calotieuhao, sophut));
        itemnamebaitapController.clear();
        itemsophutController.clear();
        itemcalotieuhaoController.clear();
      });
    }
  }
  void _removeItem1(int index) {
    setState(() {
      itemList1.removeAt(index);
    });
  }
}

