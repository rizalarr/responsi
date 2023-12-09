import 'package:flutter/material.dart';
import 'package:responsi/halaman_detail.dart';
import 'api_meal.dart';
import 'api_data_source.dart';

class ListMeals extends StatefulWidget {
  final String Category;
  const ListMeals({super.key, required this.Category});

  @override
  State<ListMeals> createState() => _ListMealsState();
}

class _ListMealsState extends State<ListMeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Category),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 146, 78, 58),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.meal(widget.Category),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('ERROR bro'),
            );
          }
          if (snapshot.hasData) {
            Meal usr = Meal.fromJson(snapshot.data!);
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: usr.meals?.length,
                itemBuilder: (context, int index) {
                  final Meals? meel = usr.meals?[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailMeals(idMeals: '${meel?.idMeal}')));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Image.network(
                                  '${meel?.strMealThumb}',
                                  height: 190,
                                  width: 170,
                              ),
                            ),
                            Text(
                                '${meel?.strMeal}',
                                textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }
          return Center(
            child: CircularProgressIndicator(color: const Color.fromARGB(255, 150, 88, 68)),
          );
        },
      ),
    );
  }
}