import 'package:flutter/material.dart';
import 'package:foodish/Screens/Home/HomeDataModel/DataModel.dart';

class TagTile extends StatelessWidget {
  final Category category;
  final int index;
  const TagTile({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(10),
      decoration: category.id == index
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.deepPurple)
          : BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.grey[500]),
      child: Text(
        category.name,
        style: category.id == index
            ? const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
            : const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
      ),
    );
  }
}
