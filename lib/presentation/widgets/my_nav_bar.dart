import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/add_post_screen.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home,
              size: 30.0,
              color: Colors.black,
            ),
          ),
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.search,
              size: 30.0,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 43, 165, 47)),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, top: 4, bottom: 4, right: 12),
                    child: IconButton(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddPostScreen(),
                      )),
                      icon: const Icon(
                        Icons.add,
                        size: 35.0,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          ),
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.favorite_border,
              size: 30.0,
              color: Colors.grey,
            ),
          ),
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.person_outline,
              size: 30.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
