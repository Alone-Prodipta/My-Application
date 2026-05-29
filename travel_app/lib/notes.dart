import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TravelNotesModule extends StatefulWidget {
  final String countryKey;
  const TravelNotesModule({super.key, required this.countryKey});

  @override
  State<TravelNotesModule> createState() => _TravelNotesModuleState();
}

class _TravelNotesModuleState extends State<TravelNotesModule> {
  final TextEditingController _noteController = TextEditingController();
  final List<String> _notes = [];
  bool _isLoadingNotes = true;
  final int _mockUserId = 1; // Swap out for active logged-in session ID context variables later

  @override
  void initState() {
    super.initState();
    _loadNotesFromDatabase();
  }

  // 🌐 PULL DATA FROM THE MYSQL DATABASE
  Future<void> _loadNotesFromDatabase() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/travel_app/manage_notes.php'),
        body: jsonEncode({
          'user_id': _mockUserId,
          'country_name': widget.countryKey,
          'action': 'fetch'
        }),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['status'] == 'success') {
          setState(() {
            _notes.clear();
            _notes.addAll(List<String>.from(result['notes']));
            _isLoadingNotes = false;
          });
        }
      }
    } catch (e) {
      setState(() => _isLoadingNotes = false);
    }
  }

  // 🌐 SAVE THE NOTE ARRAYS PERMANENTLY TO MYSQL DATABASE
  Future<void> _syncToDatabase() async {
    try {
      await http.post(
        Uri.parse('http://10.0.2.2/travel_app/manage_notes.php'),
        body: jsonEncode({
          'user_id': _mockUserId,
          'country_name': widget.countryKey,
          'notes': _notes,
          'action': 'save'
        }),
      );
    } catch (_) {}
  }

  void _addNote() {
    final noteText = _noteController.text.trim();
    if (noteText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a note before saving.')),
      );
      return;
    }

    setState(() {
      _notes.insert(0, noteText);
      _noteController.clear();
    });
    _syncToDatabase();
  }

  void _editNote(int index) {
    final editController = TextEditingController(text: _notes[index]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit note'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Note',
            ),
            maxLines: null,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedText = editController.text.trim();
                if (updatedText.isEmpty) return;
                setState(() {
                  _notes[index] = updatedText;
                });
                _syncToDatabase();
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.check),
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
    _syncToDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: const [
                Icon(Icons.note_alt, color: Color.fromARGB(255, 0, 0, 81)),
                SizedBox(width: 10),
                Text(
                  'Quick Travel Notes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Keep a short notes list for ${widget.countryKey} here.',
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Capture a destination, idea, or memory',
                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _addNote,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Save note', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 81),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 14),
            if (_isLoadingNotes)
              const Center(child: CircularProgressIndicator())
            else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Notes', style: Theme.of(context).textTheme.titleMedium),
                  Text('${_notes.length} saved', style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: _notes.isEmpty
                    ? const Center(
                        child: Text(
                          'No notes yet. Add your first travel memory!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      )
                    : ListView.separated(
                        itemCount: _notes.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                              ],
                            ),
                            child: ListTile(
                              title: Text(_notes[index], style: const TextStyle(fontSize: 14)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () => _editNote(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _deleteNote(index),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}