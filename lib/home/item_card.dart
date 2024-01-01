import 'package:flutter/material.dart';
import 'package:shop_app/models/function.dart';
import '../../constants.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.fitnessfunction, required this.press});

  final FitnessFunction fitnessfunction;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: fitnessfunction.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${fitnessfunction.id}",
                child: Image.asset(fitnessfunction.image),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            fitnessfunction.title,
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
