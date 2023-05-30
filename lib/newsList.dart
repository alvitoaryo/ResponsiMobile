import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detailNews.dart';

class NewsListPage extends StatefulWidget {
  String kategori;
  NewsListPage({Key? key, required this.kategori}) : super(key: key);

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  List<Map<String, dynamic>> home = [];
  bool load = false;

  @override
  void initState() {
    super.initState();
    fetchHome();
  }

  fetchHome() async {
    setState(() {
      load = true;
    });
    var url = "https://api-berita-indonesia.vercel.app/republika/${widget.kategori}";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> items = data['data']['posts'];

      setState(() {
        home = items
            .map((item) => {
          'title': item['title'],
          'pubDate': item['pubDate'],
          'thumbnail': item['thumbnail'],
          'description': item['description'],
          'link': item['link'],
        })
            .toList();
        load = false;
      });
    } else {
      setState(() {
        home = [];
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REPUBLIKA ${widget.kategori.toUpperCase()}"),
        centerTitle: true,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    // ignore: prefer_is_empty
    if (home.contains(null) || home.length < 0 || load) {
      return Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
          ));
    }
    return ListView.builder(
        itemCount: home.length,
        itemBuilder: (context, index) {
          return getCard(home[index]);
        });
  }

  Widget getCard(item) {
    //nama=>nama di api
    var title = item['title'];
    var pubDate = item['pubDate'];
    var thumbnail = item['thumbnail'];
    var description = item['description'];
    var link = item['link'];
    // var publisher = item['publisher'];

    return Card(
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewsDetailsScreen(
                title: title,
                pubDate : pubDate,
                thumbnail: thumbnail,
                description: description,
                link: link,
              ))),
          child: Container(
            height: MediaQuery.of(context).size.height / 7,
            padding: const EdgeInsets.all(12),
            child: ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    thumbnail.toString(),
                    width: 60,
                    height: 150,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.shop,
                        size: 90,
                      );
                    },
                  )),
              title: Text(
                title.toString(),
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
            ),
          ),
        ));
  }
}
