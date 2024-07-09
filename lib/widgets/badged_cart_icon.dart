import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_iconly/flutter_iconly.dart';

class BadgedCartIcon extends StatelessWidget {
  BadgedCartIcon({super.key, required this.count});

  int count;
  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -10, end: -12),
      showBadge: true,
      ignorePointer: false,
      badgeContent:
      Text(count.toString(),style: const TextStyle(fontSize: 12,color: Colors.white),),
      badgeAnimation: const badges.BadgeAnimation.scale(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.circle,
        badgeColor: Colors.blue,
        padding: const EdgeInsets.all(5),
        borderRadius: BorderRadius.circular(4),
        elevation: 0,
      ),
      child: const Icon(IconlyLight.buy),
    );
  }
}
