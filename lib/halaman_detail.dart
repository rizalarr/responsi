import 'package:flutter/material.dart';
import 'api_detail.dart';
import 'api_data_source.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMeals extends StatefulWidget {
  final String idMeals;
  const DetailMeals({super.key, required this.idMeals});

  @override
  State<DetailMeals> createState() => _DetailMealsState();
}

class _DetailMealsState extends State<DetailMeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail meals'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 146, 78, 58),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: ApiDataSource.instance.detail(widget.idMeals),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('ERROR bro'),
              );
            }
            if (snapshot.hasData) {
              Detail usr = Detail.fromJson(snapshot.data!);
              return ListView.builder(
                itemCount: usr.meals?.length,
                itemBuilder: (BuildContext context, int index) {
                  var dtl = usr.meals?[index];
                  return Column(
                    children: [
                      Image.network(
                        '${dtl?.strMealThumb}',
                        height: 250,
                        width: 250,
                      ),
                      SizedBox(height: 15),
                      Text(
                        '${dtl?.strMeal}',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Kategori: ${dtl?.strCategory}'),
                          Text('Area: ${dtl?.strArea}')
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Instructions', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${dtl?.strInstructions}'),
                          SizedBox(height: 20),
                          buildURLLauncher('${dtl?.strYoutube}'), // Replace URL and icon as needed
                        ],
                      ),
                    ],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(color: const Color.fromARGB(255, 36, 30, 28)),
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

    Widget buildURLLauncher(String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 146, 78, 58),
          borderRadius: BorderRadius.circular(20), 
        ),
        padding: EdgeInsets.symmetric(horizontal: 175, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_circle_fill, color: Colors.white), 
            SizedBox(width: 5),
            Text('Tonton Tutorial', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
