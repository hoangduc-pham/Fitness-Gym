import 'package:flutter/material.dart';

class FitnessFunction {
  final String image, title;
  final int size, id;
  final Color color;

  FitnessFunction(
      {required this.image,
      required this.title,
      required this.size,
      required this.id,
      required this.color});
}

List<FitnessFunction> fitnessfunctions = [
  FitnessFunction(
      id: 1,
      title: "Tính toán dinh dưỡng",
      size: 15,
      image: "assets/images/thucpham.png",
      color: Color(0xFF008080)),
  FitnessFunction(
      id: 2,
      title: "Lịch tập luyện",
      size: 15,
      image: "assets/images/lichtap.png",
      color: Colors.brown),
  FitnessFunction(
      id: 3,
      title: "Tối ưu mục tiêu",
      size: 10,
      image: "assets/images/target.png",
      color: Color(0xFFFFCC00)),
  FitnessFunction(
      id: 4,
      title: "Chạy bộ",
      size: 11,
      image: "assets/images/meohay.png",
      color: Color(0xFF6A0DAD)),
  FitnessFunction(
      id: 5,
      title: "Mẹo hay",
      size: 12,
      image: "assets/images/toiuudinhduong.png",
      color: Color(0xFF009966)),
  FitnessFunction(
    id: 6,
    title: "Tin tức khác",
    size: 12,
    image: "assets/images/tinkhac.png",
    color: Color(0xFF33CCFF),
  ),
];

