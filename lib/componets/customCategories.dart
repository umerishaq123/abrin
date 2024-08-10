import 'package:flutter/material.dart';

class CustomCategory extends StatelessWidget {
  final String imagePath;
  final String text;

  const CustomCategory({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 2, color: Colors.blue),
          ),
          child: Center(
              child: CircleAvatar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            maxRadius: 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              maxRadius: 20,
              backgroundImage: AssetImage(imagePath),
            ),
          )

              // ),
              ),
        ),
        const SizedBox(
          height: 2,
        ),
        Container(
          width: 120,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.clip,
          ),
        )
      ],
    );
  }
}
