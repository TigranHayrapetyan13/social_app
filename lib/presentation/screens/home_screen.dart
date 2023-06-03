// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:social_app/presentation/widgets/build_post.dart';

import '../widgets/build_users_lists.dart';
import '../widgets/my_nav_bar.dart';
import '../widgets/up_content.dart';

final List imageSrc = [
  'https://static01.nyt.com/images/2021/10/13/science/13shatner-launch-oldest-person-sub/13shatner-launch-oldest-person-sub-superJumbo.jpg',
  'https://www.latest-hairstyles.com/wp-content/uploads/haircuts-for-black-men-1x1-1.jpg',
  'https://www.shutterstock.com/image-photo/afro-hair-woman-smiling-while-260nw-1987819268.jpg',
  'https://i.pinimg.com/736x/e3/c0/b5/e3c0b57e39b9038b5a33a28d7953f24d.jpg',
  'https://i.pinimg.com/736x/72/31/79/723179cb2148f0293eb2aaa8e08a3daa--fresh-face-sandro.jpg'
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 229, 235),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            UppContent(),
            BuildUsersList(size: size),
            SizedBox(
              height: size.height / 1.42,
              width: double.infinity,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final post = snapshot.data!.docs[index];
                              return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: BuildPost(
                                      commentLenght: post['comments'].length,
                                      likesLenght: post['likes'].length,
                                      postId: post.id,
                                      userImage: post['userImage'],
                                      imageUrl: post['imagUrl'],
                                      description: post['description'],
                                      userName: post['userName']));
                            },
                          );
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: MyNavBar(),
    );
  }
}
