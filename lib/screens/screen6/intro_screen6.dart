import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/function.dart';
import 'screen6_page.dart';

class IntroScreen6 extends StatelessWidget {
  const IntroScreen6({super.key, required this.fitnessfunction});
  final FitnessFunction fitnessfunction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fitnessfunction.color,
      appBar: AppBar(
        title: Text('Tin tức khác'),
        titleTextStyle:TextStyle(color: Color.fromRGBO(23, 43, 68, 1), fontWeight: FontWeight.bold,fontSize: 20),
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
                'Cung cấp thông tin đa dạng về dinh dưỡng, thể hình và sức khỏe mới nhất. Bao gồm các bài viết, tin tức, lời khuyên thực tế và video hướng dẫn, chức năng này giúp người dùng tiếp cận thông tin hữu ích để cải thiện chế độ ăn uống, tập luyện và duy trì một lối sống lành mạnh.',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(23, 43, 68, 1),
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
                  MaterialPageRoute(builder: (context) => Screen6Page()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Bắt đầu khám phá',
                style: TextStyle(
                  fontSize: 20, color: Color.fromRGBO(23, 43, 68, 1), // Kích thước chữ
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
