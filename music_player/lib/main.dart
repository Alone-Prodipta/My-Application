import "package:flutter/material.dart";

void main() {
  runApp(MusicPlayer());
}

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final List<String> images = [
    
    "https://picsum.photos/id/238/250/250",
    "https://picsum.photos/id/237/250/250", // sample image 1
    "https://picsum.photos/id/239/250/250", // sample image 3
    
  ];

  int index = 0; // current image index

  void nextImage() {
    setState(() {
      index = (index + 1) % images.length;
    });
  }

  void previousImage() {
    setState(() {
      index = (index - 1 + images.length) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF002333),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: const Text("Music Player"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "December er sohore",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(252, 5, 78, 137),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // Yellow box with image
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: images[index],
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                FullScreenImage(imageUrl: images[index]),
                          ),
                        );
                      },
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              // Track bar (Slider)
              Slider(
                value: 0.3, // current position (0.0 - 1.0)
                onChanged: (value) {
                  // handle slider movement
                },
                activeColor: const Color(0xFF002333),
                inactiveColor: const Color.fromARGB(255, 100, 100, 100),
              ),

              const SizedBox(height: 20),

              // Control buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF002333),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(30),
                    ),
                    onPressed: previousImage,
                    child: const Icon(Icons.skip_previous, color: Colors.white),
                  ),

                  const SizedBox(width: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF002333),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(30),
                    ),
                    onPressed: () {
                      // handle play
                    },
                    child: const Icon(Icons.play_arrow,
                        color: Colors.white, size: 50),
                  ),

                  const SizedBox(width: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF002333),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(30),
                    ),
                    onPressed: nextImage,
                    child: const Icon(Icons.skip_next, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  const FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: imageUrl,
            child: Image.network(imageUrl),
          ),
        ),
      ),
    );
  }
}