
import 'package:abrin_app_new/Bussinesses/bussinessModel.dart';
import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  final Business business;
  final VoidCallback onTap;

  const BusinessCard({required this.business, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              business.coverPicture,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                business.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                business.location,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(business.category),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < business.rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
