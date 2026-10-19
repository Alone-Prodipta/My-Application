import 'package:flutter/material.dart';

void main() {
  runApp(const val_pass());
}

class val_pass extends StatefulWidget {
  const val_pass({super.key});

  @override
  State<val_pass> createState() => _val_passState();
}

class _val_passState extends State<val_pass> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(253, 1, 1, 62),
          title: Text("Flutter app", style: TextStyle(color: Colors.white)),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 150,
                child: Icon(Icons.person, size: 150),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(253, 1, 1, 62),
                  ),
                ),
                onPressed: () {},
                child: const Text("Submit",style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
