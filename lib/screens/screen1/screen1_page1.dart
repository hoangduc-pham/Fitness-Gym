
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
                  GestureDetector(
                    onTap: _showSuggestionDialog,
                    child: Image.asset(
                      'assets/images/gy.png', // Đường dẫn tới hình ảnh PNG của bạn
                      width: 100, // Điều chỉnh kích thước theo nhu cầu
                      height: 40,
                      // Các thuộc tính khác của hình ảnh nếu cần
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

  void _showSuggestionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDataDialog();
      },
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

class CustomDataDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.maxFinite, // Đảm bảo độ rộng tối đa
        child: ListView(
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('Loại')),
                DataColumn(label: Text('ĐV')),
                DataColumn(label: Text('Calo')),
              ],
              rows: [
                _buildDataRow('Thịt gà', '100g', '239'),
                _buildDataRow('Thịt heo', '100g', '242,1'),
                _buildDataRow('Thịt bò', '100g', '250,5'),
                _buildDataRow('Trứng gà', '100g (2 quả)', '155,1'),
                _buildDataRow('Trứng vịt', '70g (1 quả)', '130'),
                _buildDataRow('Cá ngừ', '100g', '129,8'),
                _buildDataRow('Cá hồi', '100g', '208,2'),
                _buildDataRow('Tôm', '100g', '99,2'),
                _buildDataRow('Cua', '100g', '103'),
                _buildDataRow('Thịt cừu', '100g', '294'),
                _buildDataRow('Táo', '100g', '25'),
                _buildDataRow('Cam', '100g', '47'),
                _buildDataRow('Đu đủ', '100g', '42'),
                _buildDataRow('Dưa hấu', '100g', '30,4'),
                _buildDataRow('Chuối', '100g', '88,7'),
                _buildDataRow('Bơ', '100g', '160'),
                _buildDataRow('Súp lơ', '100g', '25'),
                _buildDataRow('Cà rốt', '100g', '51'),
                _buildDataRow('Khoai lang', '100g', '86'),
                _buildDataRow('Khoai tây', '100g', '77'),
                _buildDataRow('Củ dền', '100g', '53'),
                _buildDataRow('Xà lách', '100g', '14,8'),
                _buildDataRow('Khổ qua', '100g', '17'),
                _buildDataRow('Bánh mì chả lụa', '1 ổ', '400'),
                _buildDataRow('Bún bò Huế', '1 tô', '482'),
                _buildDataRow('Bún riêu', '1 tô', '490'),
                _buildDataRow('Bún mắm', '1 tô', '480'),
                _buildDataRow('Phở', '1 tô', '450'),
                _buildDataRow('Bánh bột lọc', '1 dĩa', '487'),
                _buildDataRow('Bánh bao', '1 cái', '328'),
                _buildDataRow('Xôi mặn', '1 hộp', '500'),
                _buildDataRow('Cháo lòng', '1 tô', '412'),
                _buildDataRow('Hủ tiếu mì', '1 tô', '410'),
                _buildDataRow('Hủ tiếu xào', '1 tô', '646'),
                _buildDataRow('Bánh canh cua', '1 tô', '14,8'),
                _buildDataRow('Bún thịt nướng', '1 tô', '451'),
                _buildDataRow('Bánh mì sandwich', '1 phần hình vuông', '468'),
                _buildDataRow('Cơm tấm bì chả', '1 phần', '600'),
                _buildDataRow('Cơm chiên dương châu', '1 phần', '530'),
                _buildDataRow('Cơm thịt bò xào đậu que', '1 phần', '395'),
                _buildDataRow('Cơm với tép rang', '1 phần', '300'),
                _buildDataRow('Cơm mực xào', '1 phần', '336'),
                _buildDataRow('Cơm thịt kho tàu', '1 phần', '650'),
                _buildDataRow('Cơm canh chua cá hú', '1 phần', '360'),
                _buildDataRow('Cơm sườn nướng (1 miếng sườn)', '1 phần', '411'),
                _buildDataRow('Cơm đùi gà rô ti (1 đùi)', '1 phần', '550'),
                _buildDataRow('Cơm thịt kho tiêu', '1 phần', '400'),
                _buildDataRow('Cơm chay', '1 phần', '350'),
                _buildDataRow('Sashimi cá hồi', '100g', '200'),
                _buildDataRow('Sushi', '6 miếng (1 cuộn)', '350'),
                _buildDataRow('Sữa chua', '100g', '58,8'),
                _buildDataRow('Salad trộn hoa quả', '100g', '125'),
                _buildDataRow('Kimbap', '100g', '400'),
                _buildDataRow('Gà rán', '100g (1 miếng)', '221'),
                _buildDataRow('Tokbokki', '1 phần (300g)', '343'),
                _buildDataRow('Cơm sườn nướng (1 miếng sườn)', '1 phần', '411'),
                _buildDataRow('Trà sữa', '500ml', '608'),
                _buildDataRow('Bánh tráng trộn', '200g', '600'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
DataRow _buildDataRow(String foodType, String unit, String calo) {
  return DataRow(
    cells: [
      DataCell(Text(foodType)),
      DataCell(Text(unit)),
      DataCell(Text(calo)),
    ],
  );
}