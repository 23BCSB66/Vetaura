import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class ProfileAvatar extends StatelessWidget {
  final AvatarOption avatar;
  final double radius;
  final bool showRing;

  const ProfileAvatar({
    super.key,
    required this.avatar,
    this.radius = 24,
    this.showRing = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;

    Widget avatarChild;
    if (avatar.kind == AvatarKind.asset && avatar.assetPath != null) {
      avatarChild = ClipOval(
        child: Image.asset(
          avatar.assetPath!,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    } else {
      avatarChild = Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: avatar.colors,
          ),
        ),
        child: Icon(
          avatar.icon,
          color: Colors.white,
          size: radius * 0.95,
        ),
      );
    }

    if (!showRing) {
      return SizedBox(width: size, height: size, child: avatarChild);
    }

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.22),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: avatarChild,
    );
  }
}
