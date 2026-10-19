import 'package:flutter/material.dart';
import 'package:val_pass/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ValPass(),
    );
  }
}

class ValPass extends StatefulWidget {
  const ValPass({super.key});

  @override
  State<ValPass> createState() => _ValPassState();
}

class _ValPassState extends State<ValPass> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(253, 1, 1, 62),
        title: const Text("Flutter app", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 100,
              child: Icon(Icons.person, size: 100),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
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
              onPressed: () {
                String enteredText = controller.text.toString();
                
                // Navigate to the welcome screen and pass the entered text
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Welcome(name: enteredText),
                  ),
                );
              },
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}