import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang thanh toán'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Thông tin đơn hàng:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Tên sản phẩm'),
              subtitle: Text('Giá: \$50.00, Số lượng: 1'),
            ),
            // Thêm thông tin đơn hàng khác ở đây

            SizedBox(height: 16),

            Text(
              'Thông tin thanh toán:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Tên chủ thẻ'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Số thẻ'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Ngày hết hạn'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Mã bảo mật'),
                  ),
                ),
              ],
            ),
            // Thêm phần tử nhập thông tin thanh toán khác ở đây

            SizedBox(height: 16),

            Text(
              'Chọn phương thức thanh toán:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            RadioListTile(
              title: Text('Thẻ tín dụng'),
              value: 'credit_card',
              groupValue: null, // Thay bằng giá trị thực tế của phương thức thanh toán
              onChanged: null, // Xử lý khi người dùng thay đổi lựa chọn
            ),
            // Thêm các phương thức thanh toán khác ở đây

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                // Xử lý thanh toán ở đây (tích hợp với cổng thanh toán thực tế)
                // Sau khi thanh toán thành công, hiển thị thông báo xác nhận và quản lý đơn hàng
                // Điều hướng người dùng đến trang xác nhận đơn hàng
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text(
                'Thanh toán',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
