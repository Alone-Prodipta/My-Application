import 'package:flutter/material.dart';
import 'country_page.dart';

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
      if (countries[k].toLowerCase() == find.toLowerCase()) {
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  performLinearSearch(value);
                }
              },
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                bool isFound = foundCountry == countries[index];
                return InkWell(
                  // 🚀 NAVIGATION LOGIC CONNECTING TO THE HOMEPAGE TEMPLATE:
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text(countries[index], style: const TextStyle(color: Colors.white, fontFamily: "Algerian")),
                            backgroundColor: const Color.fromARGB(255, 0, 0, 81),
                          ),
                          body: TargetCountryPage(
                            countryName: countries[index],
                            imageUrl: 'https://res.cloudinary.com/dpffe7ryv/image/upload/${countries[index].toLowerCase().replaceAll(' ', '_')}.jpg',
                          ),
                          bottomNavigationBar: BottomNavigationBar(
                            items: const [
                              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                              BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Diary'),
                              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
                            ],
                            currentIndex: 1,
                            selectedItemColor: const Color.fromARGB(255, 0, 24, 51),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Card(
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
                  ),
                );
              },
            ),
          ),
        ],
    );
  }
}

final List<String> countries = ['Turkey','Italy','Spain','France','Greece','Japan','Australia','Brazil','Canada','Egypt','India','Mexico','Netherlands','Portugal','Russia','South Africa','Thailand','United Kingdom','United States','Vietnam'];

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> with SingleTickerProviderStateMixin {
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