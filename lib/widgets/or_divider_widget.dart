import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                color: Colors.grey,
                height: 1,
              ),
              Container(color: Colors.white, child: const Text('OR')),
            ]
      ),
    );
  }
}
