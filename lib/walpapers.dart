import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:galary_app/fullimage.dart';
import 'package:http/http.dart' as http;

class Wallpapers extends StatefulWidget {
  @override
  _WallpapersState createState() => _WallpapersState();
}

class _WallpapersState extends State<Wallpapers> {
  List images = [];
  int page = 1;
  void initState() {
    super.initState();
    fetchapi();
  }

  fetchapi() async {
    await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?page=1&per_page=40"),
        headers: {
          "Authorization":
              "563492ad6f91700001000001caa43ba95eb24694afb84c482a004cf4"
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images[0]);
    });
  }

  loadMore() async {
    setState(() {
      page = page + 1;
    });
    String url = "https://api.pexels.com/v1/curated?page=1&per_page=40&" +
        "page" +
        page.toString();
    await http.get(Uri.parse(url), headers: {
      "Authorization":
          "563492ad6f91700001000001caa43ba95eb24694afb84c482a004cf4"
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      // childAspectRatio: 0.5
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullImage(
                                        imageurl: images[index]['src']
                                            ['large2x'],
                                      )));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Image.network(
                            images[index]['src']['tiny'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              ),
            ),
            InkWell(
              onTap: loadMore,
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    "Load More",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
