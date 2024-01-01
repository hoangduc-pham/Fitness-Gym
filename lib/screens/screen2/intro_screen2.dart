import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/function.dart';
import 'screen2_page1.dart';


class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key, required this.fitnessfunction});

  final FitnessFunction fitnessfunction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fitnessfunction.color,
      appBar: AppBar(
        title: Text('Sắp xếp lịch tập'),
        backgroundColor: fitnessfunction.color,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 50),
                Expanded(
                  child: Hero(
                    tag: "${fitnessfunction.id}",
                    child: Image.asset(
                      fitnessfunction.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Tính năng sắp xếp lịch tập dựa trên thời gian từng buổi trong tuần, giúp người dùng lên kế hoạch tập luyện theo ngày. Bạn có thể xác định các buổi tập cụ thể cho mỗi ngày, như buổi tập gym vào thứ Hai, yoga và tập giãn cơ vào thứ Ba, ngày nghỉ vào thứ Tư, và các buổi tập khác tuỳ thuộc vào lịch trình của bạn.Ứng dụng cung cấp bảng lịch tuần giúp dễ dàng quản lý lịch trình tập luyện theo từng ngày.',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 16, // Đổi kích thước font
                  letterSpacing: 0.5, // Điều chỉnh khoảng cách giữa các chữ
                  height: 1.5, // Điều chỉnh khoảng cách giữa các dòng
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Screen2()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Độ cong của góc nút
                ), backgroundColor: Colors.yellow,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Khoảng cách nội dung nút và viền nút
                elevation: 5, // Độ nổi của đổ bóng
                shadowColor: Colors.grey, // Màu nền của nút là màu nâu
              ),
              child: Text(
                'Bắt đầu khám phá',
                style: TextStyle(
                  fontSize: 20, // Kích thước chữ
                  color: Color.fromRGBO(23, 43, 68, 1), // Màu chữ là màu trắng để tương phản với màu nền
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
