// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/presentation/widgets/buildComment.dart';
import 'package:social_app/service/firebase_api.dart';

class CommentsScreen extends StatelessWidget {
  final String id;
  CommentsScreen({super.key, required this.id});

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(
          child: Text(
            'Comments',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 225, 229, 235),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(id)
              .collection('comments')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final comment =
                          Comment.fromJson(snapshot.data!.docs[index].data());
                      return BuildComment(
                          imageUrl: comment.imageUrl,
                          name: comment.name,
                          comment: comment.comment);
                    },
                  )
                : SizedBox();
          }),
      bottomNavigationBar: Container(
        height: size.height / 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -2),
              blurRadius: 6.0,
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: TextField(
            controller: commentController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              contentPadding: EdgeInsets.all(20.0),
              hintText: 'Add a comment',
              suffixIcon: Container(
                margin: EdgeInsets.only(right: 4.0),
                width: 70.0,
                child: GestureDetector(
                    onTap: () async {
                      await FirebaseApi().addComment(
                          commentController: commentController, id: id);
                      commentController.clear();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.send,
                        size: 25.0,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
