import 'package:flutter/material.dart';

class MyIncome extends StatefulWidget {
  const MyIncome({super.key});

  @override
  State<MyIncome> createState() => _MyIncomeState();
}

class _MyIncomeState extends State<MyIncome> {
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    readOnly: true, // prevents typing
                    decoration: const InputDecoration(
                      hintText: "Enter the date",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? datePicked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );

                    if (datePicked != null) {
                      setState(() {
                        _dateController.text =
                            "${datePicked.day}-${datePicked.month}-${datePicked.year}";
                      });
                    }
                  },
                  child: const Icon(Icons.calendar_month),
                ),
                
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Enter the Income",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Enter the Purpose",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
