import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({ required this.title, this.subTitle, required this.leading, required this.onTap, super.key});

  String title;
  String? subTitle;
  IconData leading;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(15),
        height: 50,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(leading),
            const SizedBox(width: 25,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,style: const TextTheme().bodyMedium
                ),
                    Text( subTitle ?? '',style: const TextStyle(
                    fontSize: 15, color: Colors.grey
                ),),
              ],
            ),
            const Spacer(),
            const Icon(IconlyLight.arrowRight2)
          ],
        ),
      ),
    );
  }
}
