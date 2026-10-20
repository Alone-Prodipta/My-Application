import 'package:flutter/material.dart';
import 'notes.dart';

class TargetCountryPage extends StatelessWidget {
  final String countryName;
  final String imageUrl;

  const TargetCountryPage({
    super.key,
    required this.countryName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
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
          TravelNotesModule(countryKey: countryName),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
