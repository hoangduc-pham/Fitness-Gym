import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/function.dart';

import 'screen5_page.dart';




class IntroScreen5 extends StatelessWidget {
  const IntroScreen5({super.key, required this.fitnessfunction});

  final FitnessFunction fitnessfunction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fitnessfunction.color,
      appBar: AppBar(
        title: Text('Mẹo hay'),
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
                'Nguồn thông tin phong phú giúp người dùng tận dụng kiến thức và kinh nghiệm để cải thiện hoạt động tập luyện của họ. Bao gồm gợi ý về các bài tập đa dạng, mẹo tập luyện chuyên sâu từ các chuyên gia, thông tin dinh dưỡng và sức khỏe, chức năng này mang lại lợi ích to lớn bằng cách giúp người dùng tối ưu hóa và đa dạng hóa quá trình tập luyện.',
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
                  MaterialPageRoute(builder: (context) => Screen5Page()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Bắt đầu khám phá',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
