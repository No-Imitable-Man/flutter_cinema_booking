import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking/cinema_app_ui/consts.dart';
import 'package:flutter_cinema_booking/cinema_app_ui/models/movie_model.dart';
import 'package:flutter_cinema_booking/cinema_app_ui/pages/reservation_screen.dart';
import 'package:flutter_cinema_booking/cinema_app_ui/widgets/movie_info.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        title: Text(
          "Movie Detail",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              SizedBox(
                height: 335,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: movie.poster,
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(25),
                        child: Image.network(movie.poster),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MovieInfo(
                          icon: Icons.videocam_rounded,
                          name: "Genera",
                          value: movie.genre,
                        ),
                        MovieInfo(
                          icon: Icons.timer,
                          name: "Duration",
                          value: formatTime(Duration(minutes: movie.duration)),
                        ),
                        MovieInfo(
                          icon: Icons.star,
                          name: "Rating",
                          value: "${movie.rating}/10",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                movie.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(color: Colors.white.withOpacity(.1)),
              ),
              Text(
                "Synopsis",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15),
              Text(
                movie.synopsis,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white60,
                  height: 2,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFF1c1c27),
              blurRadius: 60,
              spreadRadius: 80,
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.transparent,
          onPressed: () {},
          label: MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ReservationScreen()),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            color: buttonColor,
            height: 60,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Center(
                child: Text(
                  "Get Reservation",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
