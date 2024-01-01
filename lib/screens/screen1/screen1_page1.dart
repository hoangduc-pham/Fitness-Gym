
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/extension_format_number.dart';
import 'screen1_page2.dart';
import 'item.dart';

class Screen1Page1 extends StatefulWidget {
  @override
  _Screen1Page1 createState() => _Screen1Page1();
}

class _Screen1Page1 extends State<Screen1Page1> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemCaloController = TextEditingController();
  List<Item> itemList = [];

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF008080),
        title: Text('Tính toán dinh dưỡng'),
        bottom: TabBar(
          indicatorColor: Colors.red,
          controller: _tabController,
          tabs: [
            Tab(text: 'Thông tin thực phẩm'),
            Tab(text: 'Kết quả'),
          ],
        ),
      ),
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background3.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          TabBarView(
            controller: _tabController,
            children: [
              _buildItemInfoTab(),
              BuildResultTab(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemInfoTab() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Expanded(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Danh sách thực phẩm:',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: _showAddItemBottomSheet,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0), // Bo tròn viền
                          border: Border.all(
                            color: Colors.white, // Màu viền
                            // Độ dày của viền
                          ),
                        ),
                        padding: EdgeInsets.all(8.0), // Khoảng cách giữa viền và nội dung
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${itemList[index].name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1.0,
                              height: 8.0,
                            ),
                            Text(
                              'Giá tiền: ${(itemList[index].price).formatNumber()} đ\nLượng Calo: ${itemList[index].calo}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.delete),
                        onPressed: () => _removeItem(index),
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
                Text('Thêm thực phẩm', style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: itemNameController,
                  decoration: InputDecoration(
                    hintText: 'Tên',
                  ),
                ),
                TextFormField(
                  controller: itemPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Giá tiền',
                  ),
                ),
                TextFormField(
                  controller: itemCaloController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Lượng Calo',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _addItemToList();
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
  Future<void> _saveItemList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemListJson = itemList.map((item) => jsonEncode(item.toMap())).toList();
    prefs.setStringList('itemList', itemListJson);
  }
  void _addItemToList() {
    String name = itemNameController.text;
    int price = int.tryParse(itemPriceController.text) ?? 0;
    int calo = int.tryParse(itemCaloController.text) ?? 0;
    if (name.isNotEmpty && price > 0 && calo > 0) {
      setState(() {
        itemList.add(Item(name, calo, price));
        itemNameController.clear();
        itemPriceController.clear();
        itemCaloController.clear();
      });
    }
  }
  void _removeItem(int index) {
    setState(() {
      itemList.removeAt(index);
    });
  }
}

