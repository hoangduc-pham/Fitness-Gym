import 'package:flutter/material.dart';

class Screen5Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mẹo hay'),
        backgroundColor: Color(0xFF009966),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gợi ý tập luyện:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                '1. Kế hoạch hóa tập luyện: Tạo một kế hoạch tập luyện hợp lý với mục tiêu cụ thể. Lập kế hoạch tháng hoặc tuần để theo dõi tiến độ.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '2. Tập luyện nhóm: Tham gia các lớp tập luyện nhóm hoặc tập thể để tăng động lực và sự cam kết.',
                style: TextStyle(fontSize: 16),
              ),
              // Thêm các gợi ý tập luyện khác ở đây...
              SizedBox(height: 24.0),
              Text(
                'Gợi ý ăn uống:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                '1. Chế độ ăn uống nhất quán: Duy trì một chế độ ăn uống đều đặn và cân đối.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '2. Sử dụng thực phẩm sạch: Chọn thực phẩm tươi ngon và ít chất bảo quản, chế biến thực phẩm tại nhà nếu có thể.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '3. Đọc nhãn sản phẩm: Hiểu rõ thành phần và giá trị dinh dưỡng của thực phẩm bạn tiêu thụ.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '4. Kiểm soát khẩu phần: Đo lường và điều chỉnh lượng thức ăn để phù hợp với mục tiêu tập luyện của bạn.',
                style: TextStyle(fontSize: 16),
              ),

              // Thêm các gợi ý ăn uống khác ở đây...
              SizedBox(height: 24.0),
              Image.asset('assets/images/tpsach.png'), // Đường dẫn ảnh của thức ăn lành mạnh
            ],
          ),
        ),
      ),
    );
  }
}
