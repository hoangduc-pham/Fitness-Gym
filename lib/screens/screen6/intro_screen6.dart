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
                  'Giú bạn quản lý chế độ ăn uống một cách thông minh và dễ dàng. Bạn có thể nhập thông tin về lượng calo và protein tiêu thụ hàng ngày, từ đó theo dõi và đánh giá chất lượng dinh dưỡng của bữa ăn.Cung cấp cho bạn thông tin tổng quan về dinh dưỡng một cách rõ ràng và dễ hiểu, giúp bạn hiểu rõ hơn về chế độ ăn uống của mình. Bằng cách này, bạn có thể điều chỉnh và cải thiện chế độ ăn uống của mình để đạt được mục tiêu về sức khỏe và cải thiện thể chất một cách hiệu quả',
                  style: TextStyle(color: Color.fromRGBO(23, 43, 68, 1),fontWeight: FontWeight.w400),
                )),
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
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Bắt đầu khám phá',
                style: TextStyle(
                  fontSize: 20, // Kích thước chữ
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
