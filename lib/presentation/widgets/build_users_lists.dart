import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class BuildUsersList extends StatelessWidget {
  const BuildUsersList({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: double.infinity,
        height: size.height / 8,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: imageSrc.length,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.all(10.0),
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45.withOpacity(0.7),
                  offset: const Offset(0, 2),
                  blurRadius: 7.0,
                ),
              ],
            ),
            child: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  height: 60.0,
                  width: 60.0,
                  imageSrc[index] as String,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
