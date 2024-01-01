import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/function.dart';

import 'screen3_page.dart';



class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key, required this.fitnessfunction});

  final FitnessFunction fitnessfunction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fitnessfunction.color,
      appBar: AppBar(
        title: Text('Tối ưu mục tiêu'),
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
                'Độ khó của các bài tập trong chương trình tập luyện có thể được điều chỉnh tăng dần để phù hợp với trình độ và tiến triển của người dùng. Ứng dụng có thể cung cấp một lịch trình linh hoạt, bắt đầu từ cường độ thấp và tăng dần lên để thách thức người dùng một cách có chủ đích. Việc điều chỉnh độ khó giúp họ duy trì động lực và tiến bộ một cách hiệu quả trong quá trình tập luyện của mình.',
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
                // Hành động khi nút được nhấn
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Screen3Page1()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Độ cong của góc nút
                ), backgroundColor: Color.fromRGBO(23, 43, 68, 1),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                elevation: 15,// Màu nền của nút là màu xanh lam
              ),
              child: Text(
                'Bắt đầu khám phá',
                style: TextStyle(
                  fontSize: 20, // Kích thước chữ
                  color: Colors.white, // Màu chữ là màu trắng
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
