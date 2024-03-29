// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './models/movieModel.dart';
import './models/tmdb.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'movieDetails.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      //theme: ThemeData.dark(),
      home: MyMovieApp(),
    ));

class MyMovieApp extends StatefulWidget {
  @override
  _MyMovieApp createState() => _MyMovieApp();
}

class _MyMovieApp extends State<MyMovieApp> {
  late Movie nowPlayingMovies;
  late Movie upcomingMovies;
  late Movie popularMovies;
  late Movie topRatedMovies;
  int heroTag = 0;
  int _currentIdex = 0;

  @override
  void initState() {
    super.initState();
    _fetchNowPlayingMovies();
    _fetchUpcomingMovies();
    _fetchPopularMovies();
    _fetchTopRatedMovies();
  }

  void _fetchNowPlayingMovies() async {
    var response = await http.get(Tmdb.nowPlayingUrl as Uri);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      nowPlayingMovies = Movie.fromJson(decodeJson);
    });
  }

  void _fetchUpcomingMovies() async {
    var response = await http.get(Tmdb.upcomingUrl as Uri);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      upcomingMovies = Movie.fromJson(decodeJson);
    });
  }

  void _fetchPopularMovies() async {
    var response = await http.get(Tmdb.popularUrl as Uri);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      popularMovies = Movie.fromJson(decodeJson);
    });
  }

  void _fetchTopRatedMovies() async {
    var response = await http.get(Tmdb.topRatedUrl as Uri);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      topRatedMovies = Movie.fromJson(decodeJson);
    });
  }

  Widget _buildCarouselSlider() => CarouselSlider(
        items: nowPlayingMovies == null
            ? <Widget>[const Center(child: CircularProgressIndicator())]
            : nowPlayingMovies.results
                .map((movieItem) => _buildMovieItem(movieItem))
                .toList(),
        options: CarouselOptions(),
      );

  Widget _buildMovieItem(Results movieItem) {
    heroTag += 1;
    movieItem.heroTag = heroTag;
    return Material(
        elevation: 15.0,
        child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => MovieDetail(movie: movieItem,)
              ));
            },
            child: Hero(
              tag: heroTag,
              child: Image.network("${Tmdb.baseImageUrl}w342${movieItem.posterPath}",
                  fit: BoxFit.cover),
            )));
  }

  Widget _buildMovieListItem(Results movieItem) => Material(
        child: Container(
            width: 128.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: _buildMovieItem(movieItem)),
                Padding(
                    padding: const EdgeInsets.only(left: 6.0, top: 2.0),
                    child: Text(
                      movieItem.title,
                      style: const TextStyle(fontSize: 8.0),
                      overflow: TextOverflow.ellipsis,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, top: 2.0),
                  child: Text(
                      DateFormat('yyyy')
                          .format(DateTime.parse(movieItem.releaseDate)),
                      style: const TextStyle(fontSize: 8.0)),
                ),
              ],
            )),
      );

  Widget _buildMoviesListView(Movie movie, String movieListTitle) => Container(
        height: 258.0,
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.00),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 7.0, bottom: 7.0),
              child: Text(
                movieListTitle,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400]),
              ),
            ),
            Flexible(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: movie == null
                    ? <Widget>[const Center(child: CircularProgressIndicator())]
                    : movie.results
                        .map((movieItem) => Padding(
                              padding: const EdgeInsets.only(left: 6.0, right: 2.0),
                              child: _buildMovieListItem(movieItem),
                            ))
                        .toList(),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Movie App',
          style: TextStyle(
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBookIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('NOW PLAYING',
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              expandedHeight: 290.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: <Widget>[
                    Container(
                      child: Image.network(
                        "${Tmdb.baseImageUrl}w500/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg",
                        fit: BoxFit.cover,
                        width: 1000.0,
                        colorBlendMode: BlendMode.dstATop,
                        color: Colors.blue.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: _buildCarouselSlider(),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: ListView(children: <Widget>[
          _buildMoviesListView(upcomingMovies, 'COMMING SOON'),
          _buildMoviesListView(popularMovies, 'POPULAR'),
          _buildMoviesListView(topRatedMovies, 'TOP RATES'),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.lightBlue,
          currentIndex: _currentIdex,
          onTap: (int index) {
            setState(() => _currentIdex = index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.local_movies), label: 'All movies'),
            BottomNavigationBarItem(
                icon: Icon(Icons.tag_faces), label:'Tickets'),
            BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Account'),
          ]),
    );
  }
}