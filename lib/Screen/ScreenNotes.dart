// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:localstorage/localstorage.dart';
import 'package:notes/Screen/ScreenAddNotes.dart';
import 'package:notes/Screen/ScreenUpdateNotes.dart';
import 'package:notes/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:notes/models/person.dart';

// ignore: must_be_immutable
class ScreenNotes extends StatefulWidget {
  ScreenNotes({super.key});
  // SharedPreferences prefs() async {
  //   return await SharedPreferences.getInstance();
  // }

  // bool? darkmode = LocalStorage('darkmode.json').getItem('themedata');
  final List<String> list = List.generate(10, (index) => "Note $index");
  @override
  State<ScreenNotes> createState() => _ScreenNotesState();
}

class _ScreenNotesState extends State<ScreenNotes> {
  toggle() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('repeat', true);
    // bool? toggleStorage = await widget.prefs.s('repeat', true);
    if (prefs.getBool('repeat') == false) {
      Notes.themeNotifier.value = ThemeMode.light;
      // print(toggleStorage);
      await prefs.setBool('repeat', true);
      // widget.darkmode = true;
    } else {
      Notes.themeNotifier.value = ThemeMode.dark;
      // widget.darkmode = false;
      await prefs.setBool('repeat', false);
      // print(toggleStorage);
    }
  }

  late final Box contactBox;

  Darkmode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool? getitem = widget.storage.getItem('themedata');
    // // WidgetsBinding.instance.addPostFrameCallback(
    // //   (_) => setState(
    // //     () {
    // //     },
    // //   ),
    // // );
    // await prefs.setBool('repeat', false);
    if (prefs.getBool('repeat') == false) {
      Notes.themeNotifier.value = ThemeMode.dark;
      // print('dark');
    } else {
      Notes.themeNotifier.value = ThemeMode.light;
      // print(getitem);
    }
  }

  _deleteInfo(int index) {
    contactBox.deleteAt(index);
  }

  bool _isGridMode = false;

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    Darkmode();
    contactBox = Hive.box('NoteBox');
    // print(storage.getItem('darkMode'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(0, 0, 0, 0), // <-- SEE HERE
        ),
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Notes.themeNotifier.value == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: toggle,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search(widget.list));
              },
              icon: Icon(Icons.search),
            ),
          ),
          if (_isGridMode)
            IconButton(
              icon: const Icon(Icons.grid_on),
              onPressed: () {
                setState(() {
                  _isGridMode = false;
                });
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                setState(() {
                  _isGridMode = true;
                });
              },
            ),
        ],
      ),
      body: _isGridMode
          ? Center(
              child: Text('GridMode'),
            )
          : ValueListenableBuilder(
              valueListenable: contactBox.listenable(),
              builder: (context, Box box, widget) {
                if (box.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Write Your First Note'),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => ScreenAddNotes(),
                                duration: Duration(milliseconds: 250),
                                transition: Transition.rightToLeftWithFade);
                          },
                          child: Text('ADD NEW NOTE'),
                        ),
                      ),
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      var currentBox = box;
                      var personData = currentBox.getAt(index)!;

                      return InkWell(
                        onTap: () {
                          Get.to(
                              () => ScreenUpdateNotes(
                                    index: index,
                                    person: personData,
                                  ),
                              duration: const Duration(milliseconds: 250),
                              transition: Transition.rightToLeftWithFade);
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                personData.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                personData.country,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          // ignore: unused_label
                                          title: Text(
                                              'Do you really want to delete the note?'),
                                          // content: Center(),
                                          // ignore: unused_label
                                          actions: <Widget>[
                                            ElevatedButton(
                                              child: const Text("Cancle"),
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                              ),
                                              onPressed: () {
                                                _deleteInfo(index);
                                                Get.back();
                                              },
                                              child: Text('Delete'),
                                            ),
                                          ]);
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Divider(),
                            Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(bottom: 15),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  personData.dateTime,
                                  key: UniqueKey(),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(() => _createRoute());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => _createRoute()),
          // );
          // Navigator.of(context).push(_createRoute());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => ScreenAddNotes(),
          //   ),
          // );
          // Get.put(_createRoute());
          // print(DateTime.now().toString());
          Get.to(() => ScreenAddNotes(),
              duration: Duration(milliseconds: 250),
              transition: Transition.rightToLeftWithFade);
          // Navigator.push(
          //   context,
          //   PageRouteBuilder(
          //     transitionsBuilder:
          //         (context, animation, secondaryAnimation, child) {
          //       return ScaleTransition(
          //         alignment: Alignment.centerRight,
          //         scale: Tween<double>(begin: 0.1, end: 1).animate(
          //           CurvedAnimation(
          //             parent: animation,
          //             curve: Curves.elasticIn,
          //           ),
          //         ),
          //         child: child,
          //       );
          //     },
          //     transitionDuration: Duration(seconds: 1),
          //     pageBuilder: (BuildContext context, Animation<double> animation,
          //         Animation<double> secondaryAnimation) {
          //       return ScreenAddNotes();
          //     },
          //   ),
          // );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => ScreenAddNotes(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return child;
//     },
//   );
// }

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        // Navigator.pop(context);
        Get.back();
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = ["Note 3", "Note 2"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            // In the false case
            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? const Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}





// body 

// class GridBuilder extends StatefulWidget {

//   @override
//   GridBuilderState createState() => GridBuilderState();
// }

// class GridBuilderState extends State<GridBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         // itemCount: widget.selectedList.length,
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (_, int index) {
//           return GridTile(
//               child: Center(),
//               );
//         });
//   }
// }

// class ListBuilder extends StatefulWidget {
//   @override
//   State<ListBuilder> createState() => _ListBuilderState();
// }

// class _ListBuilderState extends State<ListBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// body 

// class GridBuilder extends StatefulWidget {

//   @override
//   GridBuilderState createState() => GridBuilderState();
// }

// class GridBuilderState extends State<GridBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         // itemCount: widget.selectedList.length,
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (_, int index) {
//           return GridTile(
//               child: Center(),
//               );
//         });
//   }
// }

// class ListBuilder extends StatefulWidget {
//   @override
//   State<ListBuilder> createState() => _ListBuilderState();
// }

// class _ListBuilderState extends State<ListBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// body 

// class GridBuilder extends StatefulWidget {

//   @override
//   GridBuilderState createState() => GridBuilderState();
// }

// class GridBuilderState extends State<GridBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         // itemCount: widget.selectedList.length,
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (_, int index) {
//           return GridTile(
//               child: Center(),
//               );
//         });
//   }
// }

// class ListBuilder extends StatefulWidget {
//   @override
//   State<ListBuilder> createState() => _ListBuilderState();
// }

// class _ListBuilderState extends State<ListBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// body 

// class GridBuilder extends StatefulWidget {

//   @override
//   GridBuilderState createState() => GridBuilderState();
// }

// class GridBuilderState extends State<GridBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         // itemCount: widget.selectedList.length,
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (_, int index) {
//           return GridTile(
//               child: Center(),
//               );
//         });
//   }
// }

// class ListBuilder extends StatefulWidget {
//   @override
//   State<ListBuilder> createState() => _ListBuilderState();
// }

// class _ListBuilderState extends State<ListBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// body 

// class GridBuilder extends StatefulWidget {

//   @override
//   GridBuilderState createState() => GridBuilderState();
// }

// class GridBuilderState extends State<GridBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         // itemCount: widget.selectedList.length,
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (_, int index) {
//           return GridTile(
//               child: Center(),
//               );
//         });
//   }
// }

// class ListBuilder extends StatefulWidget {
//   @override
//   State<ListBuilder> createState() => _ListBuilderState();
// }

// class _ListBuilderState extends State<ListBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// body 

// class GridBuilder extends StatefulWidget {

//   @override
//   GridBuilderState createState() => GridBuilderState();
// }

// class GridBuilderState extends State<GridBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         // itemCount: widget.selectedList.length,
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (_, int index) {
//           return GridTile(
//               child: Center(),
//               );
//         });
//   }
// }

// class ListBuilder extends StatefulWidget {
//   @override
//   State<ListBuilder> createState() => _ListBuilderState();
// }

// class _ListBuilderState extends State<ListBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// body 

// class GridBuilder extends StatefulWidget {

//   @override
//   GridBuilderState createState() => GridBuilderState();
// }

// class GridBuilderState extends State<GridBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         // itemCount: widget.selectedList.length,
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (_, int index) {
//           return GridTile(
//               child: Center(),
//               );
//         });
//   }
// }

// class ListBuilder extends StatefulWidget {
//   @override
//   State<ListBuilder> createState() => _ListBuilderState();
// }

// class _ListBuilderState extends State<ListBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// body 

// class GridBuilder extends StatefulWidget {

//   @override
//   GridBuilderState createState() => GridBuilderState();
// }

// class GridBuilderState extends State<GridBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         // itemCount: widget.selectedList.length,
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (_, int index) {
//           return GridTile(
//               child: Center(),
//               );
//         });
//   }
// }

// class ListBuilder extends StatefulWidget {
//   @override
//   State<ListBuilder> createState() => _ListBuilderState();
// }

// class _ListBuilderState extends State<ListBuilder> {


//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// body 

// class GridBuilder extends StatefulWidget {

//   @override
//   GridBuilderState createState() => GridBuilderState();
// }

// class GridBuilderState extends State<GridBuilder> {
// class GridBuilderState extends State<GridBuilder> 
