// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BuildComment extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String comment;

  const BuildComment(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black45.withOpacity(0.7),
                offset: const Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: CircleAvatar(
            child: ClipOval(
                child: Image.network(
              width: 50.0,
              height: 50.0,
              imageUrl,
              fit: BoxFit.cover,
            )),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          comment,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
