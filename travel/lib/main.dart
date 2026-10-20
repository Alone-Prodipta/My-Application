import 'package:flutter/material.dart';
import 'diary.dart' as diary;
import 'notes.dart';
import 'profile.dart' as profile;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Travel App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> get _pages => [
        // Default lander targets India dynamically initially
        const TargetCountryPage(
          countryName: 'India',
          imageUrl: 'https://res.cloudinary.com/your_cloud/image/upload/india.jpg',
        ),
        const diary.CountriesPage(),
        const profile.ProfilePage(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 81),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontFamily: "Algerian"),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Diary'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: const Color.fromARGB(255, 0, 24, 51),
      ),
    );
  }
}

// 🎯 NEW DYNAMIC DETACHED VIEW FOR SELECTED COUNTRIES
class TargetCountryPage extends StatelessWidget {
  final String countryName;
  final String imageUrl;
  final bool showAppBar;

  const TargetCountryPage({
    super.key, 
    required this.countryName, 
    required this.imageUrl,
    this.showAppBar = true
  });

  @override
  Widget build(BuildContext context) {
    Widget content = SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // ☁️ DOWNLOADS IMAGES FROM CLOUDINARY LIVE
            child: Image.network(
              imageUrl,
              height: 220,
              fit: BoxFit.cover,
             
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'My Travel Memories in $countryName',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Save your ideas, memories, and travel plans for $countryName right here.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 18),
          TravelNotesModule(countryKey: countryName), // Pass reference down
          const SizedBox(height: 20),
        ],
      ),
    );

    if (showAppBar) {
      return Scaffold(
        appBar: AppBar(
          title: Text(countryName, style: const TextStyle(color: Colors.white, fontFamily: "Algerian"),),
          backgroundColor: const Color.fromARGB(255, 0, 0, 81),
        ),
        body: content,
      );
    }
    return content;
  }
}