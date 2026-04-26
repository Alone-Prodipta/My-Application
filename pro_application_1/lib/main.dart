import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
              top: 10,
              right: 0,
              child: Container(
                width: 180,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromARGB(255, 251, 3, 243),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Nayeb",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    decorationStyle: TextDecorationStyle.wavy,
                    decorationThickness: 2.0,
                    decorationColor: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 0,
              child: Container(
                width: 180,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromARGB(255, 251, 3, 243),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Prodipta",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    decorationStyle: TextDecorationStyle.wavy,
                    decorationThickness: 2.0,
                    decorationColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}