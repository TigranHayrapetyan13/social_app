import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post_model.dart';

import '../models/user_model.dart';

class FirebaseApi {
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final currentUSer = FirebaseAuth.instance.currentUser;
  Future addUser({
    required File? image,
    required String name,
    required String email,
    required String password,
  }) async {
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageReference = FirebaseStorage.instance.ref();
    Reference bucketRef = storageReference.child('images');
    Reference imageRef = bucketRef.child(uniqueName);

    final snapshot = await imageRef.putFile(image!).whenComplete(() => null);
    final imageUrl = await snapshot.ref.getDownloadURL();

    final newUser = NewUser(
      name: name,
      email: email,
      avatarUrl: imageUrl,
    );

    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    user!.updateDisplayName(name);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.email)
        .set(newUser.toJson());
  }

  Future addPost(
      {required File? image,
      required TextEditingController descriptionController}) async {
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageReference = FirebaseStorage.instance.ref();
    Reference bucketRef = storageReference.child('posts');
    Reference imageRef = bucketRef.child(uniqueName);

    final snapshot = await imageRef.putFile(image!).whenComplete(() => null);

    final imageUrl = await snapshot.ref.getDownloadURL();
    final userData = await usersCollection.doc(currentUSer!.email).get();
    final userImage = userData['avatarUrl'];
    Post post = Post(
        comments: [],
        likes: [],
        userImage: userImage,
        userName: userData['name'],
        description: descriptionController.text,
        imagUrl: imageUrl,
        time: DateTime.now());

    FirebaseFirestore.instance.collection('posts').add(post.toJson());
  }

  Future addComment(
      {required TextEditingController commentController,
      required String id}) async {
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('posts').doc(id);
    postRef.update({
      'comments': FieldValue.arrayUnion([uniqueName])
    });
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUSer!.email)
        .get();
    Comment comment = Comment(
        comment: commentController.text,
        imageUrl: userData['avatarUrl'],
        name: userData['name'],
        time: DateTime.now());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .collection('comments')
        .add(comment.toJson());
  }
}
