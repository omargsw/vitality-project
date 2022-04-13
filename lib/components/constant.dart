import 'package:flutter/material.dart';

void showDoneSnackBar(BuildContext context,String text) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.done_outline, size: 20,color: Colors.green,),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15,color: Colors.green),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black45,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

void showErrorSnackBar(BuildContext context,var text) {
  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(Icons.error_outline, size: 20,color: Colors.black,),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}