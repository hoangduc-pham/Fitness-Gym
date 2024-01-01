import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/function.dart';
import 'package:shop_app/screens/screen1/screen1_page1.dart';


class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key, required this.fitnessfunction});

  final FitnessFunction fitnessfunction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fitnessfunction.color,
      appBar: AppBar(
        title: Text('Tính toán dinh dưỡng'),
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
                'Tính năng tính toán dinh dưỡng theo số tiền chi trả cho mỗi bữa ăn giúp người dùng xây dựng chế độ ăn uống cân đối. Bằng cách nhập ngân sách cho bữa ăn, người dùng nhận được gợi ý thực phẩm phù hợp. Ứng dụng tính toán calo, protein, carb và chất béo từ các món đề xuất, đảm bảo khẩu phần đủ chất và đáp ứng nhu cầu dinh dưỡng cá nhân. Điều này giúp tiết kiệm chi phí và duy trì lối sống ăn uống lành mạnh.',
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
                  MaterialPageRoute(builder: (context) => Screen1Page1()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ), backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                elevation: 15, // Độ nổi của đổ bóng
                shadowColor: Colors.grey, // Màu sắc nền của nút
              ),
              child: Text(
                'Bắt đầu khám phá',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white, // Màu chữ của nút
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
