import 'package:flutter/material.dart';

class ErrorRefreshIcon extends StatelessWidget {
  ErrorRefreshIcon(
      {required this.onPressed, this.errorMessage, Key? key})
      : super(key: key);
  Function() onPressed;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            Text(
              errorMessage?? "Error",
              style: const TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 20,
                fontFamily: 'Avenir',
              ),
            ),
            IconButton(
              splashColor: Colors.black,
              onPressed: onPressed,
              icon: Container(
                child:  Center(child: Icon(Icons.refresh)),
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              ),
            )
          ],
        ));
  }
}
