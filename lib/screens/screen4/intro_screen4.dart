import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/function.dart';
import 'screen4_page.dart';

class IntroScreen4 extends StatelessWidget {
  const IntroScreen4({super.key, required this.fitnessfunction});

  final FitnessFunction fitnessfunction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fitnessfunction.color,
      appBar: AppBar(
        title: Text('Chạy bộ'),
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
                'Ứng dụng tập luyện trên bản đồ tập trung vào việc lên kế hoạch và tối ưu hóa quãng đường tập luyện theo mục tiêu khoảng cách cá nhân. Người dùng có thể đặt điểm xuất phát và đích trên bản đồ để lên lịch trình tập luyện sao cho hiệu quả nhất mà không cần sử dụng GPS. Điều này giúp họ tập trung vào việc chạy bộ hoặc đạp xe trên đường đi tối ưu nhất để đạt được mục tiêu cá nhân một cách thuận tiện.',
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
                // Hành động khi nút được nhấn
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Screen4Page()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Độ cong của góc nút
                ), backgroundColor: Colors.yellow,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                elevation: 15,// Màu nền của nút là màu xanh lam
              ),
              child: Text(
                'Bắt đầu khám phá',
                style: TextStyle(
                  fontSize: 20,color: Color.fromRGBO(23, 43, 68, 1), // Kích thước chữ
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
