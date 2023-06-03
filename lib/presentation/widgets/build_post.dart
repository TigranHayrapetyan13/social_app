import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../screens/comments_screen.dart';

class BuildPost extends StatefulWidget {
  final int commentLenght;
  final int likesLenght;
  final String postId;
  final String imageUrl;
  final String userName;
  final String description;
  final String? userImage;
  const BuildPost(
      {super.key,
      required this.commentLenght,
      required this.postId,
      required this.userImage,
      required this.imageUrl,
      required this.description,
      required this.userName,
      required this.likesLenght});

  @override
  State<BuildPost> createState() => _BuildPostState();
}

class _BuildPostState extends State<BuildPost> {
  bool isLiked = false;
  final currentUserEmail = FirebaseAuth.instance.currentUser!.email;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'likes': FieldValue.arrayUnion([currentUserEmail])
      });
    } else {
      postRef.update({
        'likes': FieldValue.arrayRemove([currentUserEmail])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Container(
        width: double.infinity,
        height: size.height / 1.43,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: size.width / 7.5,
                      height: size.height / 5,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: ClipOval(
                            child: Image.network(
                          widget.userImage!,
                          fit: BoxFit.cover,
                          width: size.width / 7.5,
                          height: size.height / 5,
                        )),
                      ),
                    ),
                    title: Text(
                      widget.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(widget.description),
                    trailing: const Icon(
                      Icons.more_horiz,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onDoubleTap: () {},
                    onTap: () {
                      toggleLike();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: double.infinity,
                      height: size.height / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45.withOpacity(0.7),
                            offset: const Offset(0, 5),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: !isLiked
                                      ? const Icon(Icons.favorite_border)
                                      : const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                  iconSize: 30.0,
                                  onPressed: () => toggleLike(),
                                ),
                                Text(
                                  widget.likesLenght.toString(),
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20.0),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.chat),
                                  iconSize: 30.0,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CommentsScreen(
                                          id: widget.postId,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  widget.commentLenght.toString(),
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.bookmark_border),
                          iconSize: 30.0,
                          onPressed: () => print(size.height),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
