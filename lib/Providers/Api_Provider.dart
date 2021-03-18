import 'dart:convert';

import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiProvider with ChangeNotifier {
  List<dynamic> standings = [];
  bool isloading = true;
  List fixture = [];
  List StatisticsHome = [];
  List StatisticsAway = [];
  bool isloadingStatistics = true;
  bool isloadingStandings = true;
  bool isloadingTopScore = true;
  List TopScorse = [];
  Future getstandingsData() async {
    final url =
        "https://v3.football.api-sports.io/standings?league=39&season=2020";
    try {
      http.Response response = await http.get(url, headers: {
        "x-rapidapi-host": "v3.football.api-sports.io",
        "x-rapidapi-key": "327b9920aebc75caa694151d5c9f2533"
      });
      if (response.statusCode == 200) {
        try {
          var decode = json.decode(response.body);
          standings = decode['response'][0]['league']['standings'][0];


          notifyListeners();
        } catch (e) {
          throw e;
        }
      }
    } on SocketException catch (a) {
      throw a.message;
    } on RangeError catch (s) {
      throw s.message;
    }
  }

  Future getMatchesOfTheDay() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);

    final url =
        "https://v3.football.api-sports.io/fixtures?date=${formatted}&league=39&season=2020";
    try {
      http.Response response = await http.get(url, headers: {
        "x-rapidapi-host": "v3.football.api-sports.io",
        "x-rapidapi-key": "327b9920aebc75caa694151d5c9f2533"
      }).catchError((e) => throw e);
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        fixture = res['response'];
        notifyListeners();
        return fixture;
      }
    } on SocketException catch (a) {
      throw a.message;
    } on RangeError catch (s) {
      throw s.message;
    }
  }

  getStatisticsHome(var fixtureId, var idTeam) async {
    final url =
        "https://v3.football.api-sports.io/fixtures/statistics?fixture=${fixtureId.toString()}&team=${idTeam.toString()}";
    try {
      http.Response response = await http.get(url, headers: {
        "x-rapidapi-host": "v3.football.api-sports.io",
        "x-rapidapi-key": "327b9920aebc75caa694151d5c9f2533"
      });

      if (response.statusCode == 200) {
        try {
          var res = json.decode(response.body);
          StatisticsHome = res['response'];
          notifyListeners();

        } catch (e) {
          print(e);
          throw e;
        }
      }
    } on SocketException catch (a) {
      throw a.message;
    } on RangeError catch (s) {
      throw s.message;
    }
  }

  getStatisticsAway(var fixtureId, var idTeam) async {
    final url =
        "https://v3.football.api-sports.io/fixtures/statistics?fixture=${fixtureId.toString()}&team=${idTeam.toString()}";

    try {
      http.Response response = await http.get(url, headers: {
        "x-rapidapi-host": "v3.football.api-sports.io",
        "x-rapidapi-key": "327b9920aebc75caa694151d5c9f2533"
      });

      if (response.statusCode == 200) {
        try {
          var res = json.decode(response.body);
          StatisticsAway = res['response'];
          notifyListeners();

        } catch (e) {
          print(e);
          throw e;
        }
      }
    } on SocketException catch (a) {
      throw a.message;
    } on RangeError catch (s) {
      throw s.message;
    }
  }

  Future TopScoresData() async {
    final url =
        "https://v3.football.api-sports.io/players/topscorers?season=2020&league=39";
    try {
      http.Response response = await http.get(url, headers: {
        "x-rapidapi-host": "v3.football.api-sports.io",
        "x-rapidapi-key": "327b9920aebc75caa694151d5c9f2533"
      });
      if (response.statusCode == 200) {
        try {
          var decode = json.decode(response.body);

          TopScorse = decode['response'];

          notifyListeners();
        } catch (e) {
          throw e;
        }
      }
    } on SocketException catch (a) {
      throw a.message;
    } on RangeError catch (s) {
      throw s.message;
    }
  }

  Future getTeamDetails(int teamid) async {
    final url ="https://v3.football.api-sports.io/teams/statistics?season=2020&team=${teamid}&league=39";
    try {
      http.Response response = await http.get(url, headers: {
        "x-rapidapi-host": "v3.football.api-sports.io",
        "x-rapidapi-key": "327b9920aebc75caa694151d5c9f2533"
      });
      if (response.statusCode == 200) {
          var decode = json.decode(response.body);
          notifyListeners();
          return decode['response'];

      }
    } on SocketException catch (a) {
      throw a.message;
    } on RangeError catch (s) {
      throw s.message;
    }
  }

}
