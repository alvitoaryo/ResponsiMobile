import 'package:flutter/material.dart';
import 'newsList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alvito Aryo Prabowo-123200158',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://static.republika.co.id/files/images/logo.png',
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height/4,
            ),
        SizedBox(height: 60),
        Container(
          width: 230,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  NewsListPage(kategori : 'terbaru')));
            },
              child: const Text("Terbaru")),
        ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 230,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  NewsListPage(kategori : 'daerah')));
                  },
                  child: const Text("Daerah")),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 230,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  NewsListPage(kategori : 'internasional')));
                  },
                  child: const Text("Internasional")),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 230,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  NewsListPage(kategori : 'islam')));
                  },
                  child: const Text("Islam")),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
