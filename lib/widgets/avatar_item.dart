import 'package:flutter/material.dart';

class AvatarItem extends StatelessWidget {
  final String photoUrl;
  const AvatarItem({super.key, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage(
              photoUrl,
            ),
            fit: BoxFit.contain),
      ),
    );
  }
}
