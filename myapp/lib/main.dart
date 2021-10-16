import 'package:flutter/material.dart';
import 'package:username_generator/username_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
      title: 'My Flutter App',
      home: Username(),
    );
  }
}

//main component of Home page
class Username extends StatefulWidget {
  @override
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  @override
  //array for holding all username
  var _items = <String>[];
  //set for holding liked username
  var _liked = <String>{};
  //a random username generator
  var generator = UsernameGenerator();
  //Indie Flower text style for this list view
  final indieStyle = const TextStyle(
      fontFamily: 'Indie', fontSize: 20, fontWeight: FontWeight.bold);
  //NotoSans Mono style
  final notoStyle = const TextStyle(fontFamily: 'NotoSans', fontSize: 24);
  //a divider between items
  final seperator = const Divider(
    color: Colors.grey,
    thickness: 0.5,
  );

  //function for building app bar
  PreferredSizeWidget getAppBar() {
    return AppBar(
      title: Text(
        "Andy's First App",
        style: notoStyle,
      ),
    );
  }

  //build an infinite scroll list of random usernames
  Widget buildUsernameList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int i) {
        //seperate items with divider
        if (i.isOdd) {
          return seperator;
        }

        int index = i ~/ 2;
        //reach the end of the array. Add more username to our list
        if (index >= _items.length) {
          for (int i = 0; i < 10; i++) {
            _items.add(generator.generateRandom());
          }
        }

        //contrusct a new list tile with newly generated username
        return getItem(_items[index]);
      },
    );
  }

  //build a list tile with a username and its status (liked or not)
  Widget getItem(String username) {
    final isLiked = _liked.contains(username);
    return ListTile(
      title: Text(username, style: indieStyle),
      trailing: Icon(
        isLiked ? Icons.thumb_up_rounded : Icons.thumb_up_outlined,
        color: isLiked ? Colors.orange : null,
        semanticLabel: isLiked ? 'Unlike' : 'Like',
      ),
      onTap: () {
        setState(() {
          if (isLiked) {
            _liked.remove(username);
          } else {
            _liked.add(username);
          }
        });
      },
    );
  }

  //method to return list of nav bar items for bottom nav bar
  List<BottomNavigationBarItem> getHomeBottomNavBarItems() {
    var collections = <BottomNavigationBarItem>[];

    //home button
    collections.add(BottomNavigationBarItem(
      label: 'Home',
      icon: const Icon(
        Icons.home,
        color: Colors.orange,
      ),
    ));

    //fun page button
    collections.add(BottomNavigationBarItem(
      label: 'Fun',
      icon: Icon(
        Icons.mood,
        color: null,
      ),
    ));

    return collections;
  }

  //get bottom navbar for Home Page
  Widget getHomeBottomNavigationBar() {
    return BottomNavigationBar(
      items: getHomeBottomNavBarItems(),
      //this only trigger if clicked fun page icon
      onTap: (int i) {
        if (i == 1) {
          goToFunPage();
        }
      },
    );
  }

  //construct the username list with like button functionality
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: getAppBar(),
      body: Container(
          child: Center(
              child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            child: const Center(
              child: Text(
                "This is a mobile app developed by Andy to show his skills. Please click thumbs up if you like the username.",
                style: TextStyle(fontFamily: 'NotoSans', fontSize: 16),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(child: buildUsernameList()),
        ],
      ))),
      bottomNavigationBar: getHomeBottomNavigationBar(),
    );
  }

  //on tap function for navigating to fun page
  void goToFunPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          int totalLiked = _liked.length;
          //definition of fun page
          return Scaffold(
            appBar: AppBar(title: Text('Fun Page')),
            body: Container(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total Usernames liked',
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      '$totalLiked',
                      style: const TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 24,
                      ),
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: getFunPageBottomNavigationBar(),
          );
        },
      ),
    );
  }

  /*STARTING OF FUNCTIONS FOR FUN PAGE */

  //method to build bottom navigation bar for fun page
  Widget getFunPageBottomNavigationBar() {
    return BottomNavigationBar(
      items: getFunPageNavBarItems(),
      //go back to home page
      onTap: (int i) {
        if (i == 0) {
          goToHomePage();
        }
      },
    );
  }

  //method to return a list of nav bar items for fun page
  List<BottomNavigationBarItem> getFunPageNavBarItems() {
    var collections = <BottomNavigationBarItem>[];

    //home button
    collections.add(BottomNavigationBarItem(
      label: 'Home',
      icon: const Icon(
        Icons.home,
        color: null,
      ),
    ));

    //fun page button
    collections.add(BottomNavigationBarItem(
      label: 'Fun',
      icon: Icon(
        Icons.mood,
        color: Colors.orange,
      ),
    ));

    return collections;
  }

  //method to return back to home page
  void goToHomePage() {
    Navigator.pop(context);
  }
}

/*END OF DEFINITION OF THE APP */
