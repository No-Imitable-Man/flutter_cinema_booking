import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking/cinema_app_ui/consts.dart';
import 'package:flutter_cinema_booking/cinema_app_ui/models/category_model.dart';
import 'package:flutter_cinema_booking/cinema_app_ui/models/movie_model.dart'
    show movies;
import 'package:flutter_cinema_booking/cinema_app_ui/pages/detail_page.dart';

class HomePageCinema extends StatefulWidget {
  const HomePageCinema({super.key});

  @override
  State<HomePageCinema> createState() => _HomePageCinemaState();
}

class _HomePageCinemaState extends State<HomePageCinema> {
  late PageController controller;
  double pageoffSet = 1;
  int currentIndex = 1;
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 1, viewportFraction: 0.6)
      ..addListener(() {
        setState(() {
          pageoffSet = controller.page!;
        });
      });
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: headerParts(),
      body: Column(
        children: [
          SizedBox(height: 35),
          SearchField(),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "See all",
                          style: TextStyle(
                            fontSize: 13,
                            color: buttonColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: buttonColor,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 17),
                categoryItems(),
                SizedBox(height: 40),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Showing this month",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PageView.builder(
                        controller: controller,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index % movies.length;
                          });
                        },
                        itemBuilder: (context, index) {
                          double scale = max(
                            0.6,
                            (1 - (pageoffSet - index).abs() + 0.6),
                          );
                          double angle =
                              (controller.position.haveDimensions
                                  ? index.toDouble() - (controller.page ?? 0)
                                  : index.toDouble() - 1) *
                              5;
                          angle = angle.clamp(-5, 5);
                          final movie = movies[index % movies.length];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MovieDetailPage(movie: movie),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 100 - (scale / 1.6 * 100),
                              ),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Transform.rotate(
                                    angle: angle * pi / 90,
                                    child: Hero(
                                      tag: movie.poster,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.network(
                                          movie.poster,
                                          height: 300,
                                          width: 205,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 330,
                        child: Row(
                          children: List.generate(
                            movies.length,
                            (index) => AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.only(right: 15),
                              width: currentIndex == index ? 30 : 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? buttonColor
                                    : Colors.white24,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row categoryItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        categories.length,
        (index) => Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white10.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(
                categories[index].emoji,
                fit: BoxFit.cover,
                height: 30,
                width: 30,
              ),
            ),
            SizedBox(height: 10),
            Text(
              categories[index].name,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Padding SearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 19),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white54),
          prefixIcon: Icon(Icons.search, size: 30),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  AppBar headerParts() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Welcome Angelina",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Let's relax and watch a movie!",
                  style: TextStyle(
                    height: 0.6,
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            Container(
              width: 40,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://t3.ftcdn.net/jpg/06/07/84/82/240_F_607848231_w5iFN4tMmtI2woJjMh7Q8mGvgARnzHqQ.jpg",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
