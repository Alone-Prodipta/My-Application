import 'package:flutter/material.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  late TextEditingController _searchController;
  String? foundCountry;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void performLinearSearch(String find) {
    String? found;
    for (int k = 0; k < countries.length; k++) {
      if (countries[k] == find) {
        found = countries[k];
        break;
      }
    }
    setState(() {
      foundCountry = found;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Text field at the top
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your text',
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  performLinearSearch(value);
                }
              },
            ),
          ),

          const SizedBox(height: 15),

          // Scrollable list below
          Expanded(
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                bool isFound = foundCountry == countries[index];
                return Card(
                  color: isFound ? Colors.yellowAccent : Colors.white,
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

final List<String> countries = ['Turkey','Italy','Spain','France','Greece','Japan','Australia','Brazil','Canada','Egypt','India','Mexico','Netherlands','Portugal','Russia','South Africa','Thailand','United Kingdom','United States','Vietnam'];
class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}