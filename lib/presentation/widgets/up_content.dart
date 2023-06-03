import 'package:flutter/material.dart';
import 'package:social_app/service/auth_service.dart';

class UppContent extends StatelessWidget {
  const UppContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Instagram',
            style: TextStyle(
              fontSize: 32.0,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.live_tv_rounded,
                size: 30,
              ),
              SizedBox(width: 16.0),
              Icon(
                Icons.send,
                size: 30,
              ),
              IconButton(
                  onPressed: () async => await AuthService().logOut(),
                  icon: Icon(Icons.logout_rounded))
            ],
          )
        ],
      ),
    );
  }
}
