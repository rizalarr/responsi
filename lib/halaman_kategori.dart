import 'package:flutter/material.dart';
import 'package:responsi/halaman_meal.dart';
import 'api_data_source.dart';
import 'api_kategori.dart';

class kategori extends StatefulWidget {
  const kategori({super.key});

  @override
  State<kategori> createState() => _kategoriState();
}

class _kategoriState extends State<kategori> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori meal'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 146, 78, 58),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.kategori(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('ERROR broo'),
            );
          }
          if (snapshot.hasData) {
            Kategori usr = Kategori.fromJson(snapshot.data!);
            return ListView.builder(
                itemCount: usr.categories?.length,
                itemBuilder: (BuildContext context, int index) {
                  var kategori = usr.categories?[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListMeals(Category: '${kategori?.strCategory}'),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            children: [
                              Image.network(
                                  '${kategori?.strCategoryThumb}',
                                  height: 120,
                                  width: 120,
                              ),
                              Text(
                                  '${kategori?.strCategory}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                    '${kategori?.strCategoryDescription}',
                                    textAlign: TextAlign.justify,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            );
          }
          return Center(
            child: CircularProgressIndicator(color: const Color.fromARGB(255, 103, 72, 63)),
          );
        },
      ),
    );
  }
}