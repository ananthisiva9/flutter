import 'package:flutter/material.dart';

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: const EdgeInsets.only(top: 10),
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 50, width: 50),
        child: const CircularProgressIndicator(
          color: Colors.indigo,
          strokeWidth: 4,
        ),
      ),
    );
  }
}
