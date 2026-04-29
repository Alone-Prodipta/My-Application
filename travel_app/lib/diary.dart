import 'package:flutter/material.dart';

class CountriesPage extends StatelessWidget {
  const CountriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Countries")),
      body: Column(
        children: [
          // Text field at the top
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your text',
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Scrollable list below
          Expanded(
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      countries[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final List<String> countries = [
  'Turkey',
  'Italy',
  'Spain',
  'France',
  'Greece',
  'Japan',
  'Australia',
  'Brazil',
  'Canada',
  'Egypt',
  'India',
  'Mexico',
  'Netherlands',
  'Portugal',
  'Russia',
  'South Africa',
  'Thailand',
  'United Kingdom',
  'United States',
  'Vietnam',
];
