import 'package:flutter/material.dart';

void main() {
  runApp(GalleryApp());
}

class GalleryApp extends StatelessWidget {
  final List<String> images = [
    "https://picsum.photos/id/1011/400/400",
    "https://picsum.photos/id/1015/400/400",
    "https://picsum.photos/id/1021/400/400",
    "https://picsum.photos/id/1025/400/400",
    "https://picsum.photos/id/1035/400/400",
    "https://picsum.photos/id/1043/400/400",
  ];

   GalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Basic Gallery App"),
          backgroundColor: Colors.deepPurple,
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // two images per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullScreenImage(imageUrl: images[index]),
                  ),
                );
              },
              child: Hero(
                tag: images[index],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  const FullScreenImage({super.key, required this.imageUrl});

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