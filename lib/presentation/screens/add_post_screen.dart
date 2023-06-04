import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:social_app/service/firebase_api.dart';

import '../../main.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController descriptionController = TextEditingController();
  File? img;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      img = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: () async {
                    await pickImage();
                  },
                  child: CircleAvatar(
                    radius: 150,
                    backgroundColor: Colors.blueGrey,
                    child: img == null
                        ? const Icon(Icons.add_a_photo_outlined,
                            size: 40, color: Colors.grey)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              img!,
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  maxLines: 10,
                  expands: false,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 202, 201, 216),
                      hintText: 'description',
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 43, 165, 47)),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 50, top: 4, bottom: 4, right: 50),
                    child: IconButton(
                      onPressed: () async {
                        if (img == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('pls add photo'),
                            ),
                          );
                        } else {
                          showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: ((context) => const Center(
                                    child: CircularProgressIndicator(),
                                  )));

                          await FirebaseApi().addPost(
                              image: img,
                              descriptionController: descriptionController);
                          myNavigatorKey.currentState!
                              .popUntil((route) => route.isFirst);
                        }
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 35.0,
                        color: Colors.white,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
