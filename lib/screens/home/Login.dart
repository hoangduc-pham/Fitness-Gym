import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shop_app/models//icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp1());
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Thêm GlobalKey<FormState>

  @override
  void dispose() {
    passwordController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Hàm kiểm tra mật khẩu
  String? validatePassword(String? value) {
    if (value != null && value.length < 8) {
      return 'Mật khẩu tối thiểu 8 kí tự';
    }
    return null;
  }
  RxBool yourCheckBoxValue = false.obs; //checkbox

  @override
  void initState() {
    super.initState();
    loadSavedData(); // Load dữ liệu từ SharedPreferences khi màn hình được tạo
  }

  // Hàm để tải dữ liệu đã lưu từ SharedPreferences
  void loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      yourCheckBoxValue.value = prefs.getBool('checkBoxValue') ?? true;
      if (yourCheckBoxValue.value) {
        phoneController.text = prefs.getString('phone') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  // Hàm để lưu dữ liệu vào SharedPreferences
  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('checkBoxValue', yourCheckBoxValue.value);
    if (yourCheckBoxValue.value) {
      prefs.setString('phone', phoneController.text);
      prefs.setString('password', passwordController.text);
    } else {
      prefs.remove('phone');
      prefs.remove('password');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppIcon.backgroundIcon),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                const SizedBox(height: 100),
                SvgPicture.asset(
                  AppIcon.logoIcon,
                  width: 300,
                  height: 300,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 508,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 9,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(11),
                    child: Form(
                      key: _formKey, // Gán GlobalKey<FormState> vào Form
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Đăng nhập',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(23, 43, 68, 1),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Số điện thoại',
                            style: TextStyle(
                              color: Color.fromRGBO(23, 43, 68, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: double.infinity,
                            height: 48,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(1),
                              border: Border.all(
                                color: Color.fromRGBO(239, 239, 239, 1),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  child: SvgPicture.asset(AppIcon.sdtIcon),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]'),
                                      ),
                                    ],
                                    keyboardType: TextInputType.number,
                                    controller: phoneController,
                                    decoration: InputDecoration(
                                      hintText: 'Nhập số điện thoại',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Mật khẩu',
                            style: TextStyle(
                              color: Color.fromRGBO(23, 43, 68, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: double.infinity,
                            height: 48,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(1),
                              border: Border.all(
                                color: Color.fromRGBO(239, 239, 239, 1),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  child: SvgPicture.asset(AppIcon.mkIcon),
                                ),
                                SizedBox(width: 05),
                                Expanded(
                                  child: TextFormField(
                                    obscureText: !isPasswordVisible,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      hintText: 'Nhập mật khẩu',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    validator: validatePassword,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        Row(
                          children: [
                            Obx(
                                  () => Checkbox(
                                value: yourCheckBoxValue.value,
                                onChanged: (bool? value) {
                                  setState(() {
                                    yourCheckBoxValue.value = value!;
                                  });
                                  saveData(); // Lưu dữ liệu khi CheckBox thay đổi trạng thái
                                },
                              ),
                            ),
                            const Text(
                              'Ghi nhớ đăng nhập!',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                // Xử lý khi bấm vào chữ quên mật khẩu
                              },
                              child: const Text(
                                'Quên mật khẩu?',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                          Align(
                            alignment: Alignment.center,
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Mật khẩu hợp lệ, xử lý khi bấm vào nút đăng nhập
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    'Đăng nhập',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                // Xử lý khi bấm vào chữ "Bạn chưa có tài khoản? Đăng ký"
                              },
                              child: Text('Bạn chưa có tài khoản?',
                                  style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: OutlinedButton(
                              onPressed: () {
                                // Xử lý khi bấm vào chữ "Bạn chưa có tài khoản? Đăng ký"
                              },
                              child: Text('Đăng ký',
                                  style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                              ),
                              Text(
                                'or',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Thêm logo cho Google
                              GestureDetector(
                                onTap: () {
                                  // Xử lý khi bấm vào logo Google
                                },
                                child: Image.asset(
                                  'assets/icons/logo_google.png',
                                  // Đường dẫn đến hình ảnh logo Google
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              SizedBox(width: 20),
                              // Thêm logo cho Facebook
                              GestureDetector(
                                onTap: () {
                                  // Xử lý khi bấm vào logo Facebook
                                },
                                child: Image.asset(
                                  'assets/icons/logo_facebook.png',
                                  // Đường dẫn đến hình ảnh logo Facebook
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
