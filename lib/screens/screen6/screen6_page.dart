import 'package:flutter/material.dart';

class Screen6Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tin tức khác'),
        backgroundColor: Color(0xFF33CCFF),
        titleTextStyle:TextStyle(color: Color.fromRGBO(23, 43, 68, 1), fontWeight: FontWeight.bold,fontSize: 20),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ăn tối thiểu 2 con cá mỗi ngày sẽ giúp bạn khỏe hơn',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Ngày đăng: 30/12/2023',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 16.0),
              Image.asset('assets/images/tpss.jpg'),
              SizedBox(height: 16.0),
              Text(
                'Nội dung bài báo...',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              Text(
                'Tác giả: John Doe',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
