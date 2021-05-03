import 'package:flutter/material.dart';

const _avatarSize = 24.0;

class Avatar extends StatelessWidget {
  const Avatar({Key? key, required this.photo}) : super(key: key);

  final String? photo;

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    return CircleAvatar(
      radius: _avatarSize,
      // This is a weird problem .. How would I solve?
      backgroundImage: NetworkImage(photo!),
      // child: const Icon(Icons.person_outline, size: _avatarSize),
    );
  }
}
