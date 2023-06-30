// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/Screen/ScreenAddNotes.dart';
import 'package:notes/Screen/ScreenUpdateNotes.dart';
import 'package:notes/main.dart';
// import 'package:notes/models/person.dart';

// ignore: must_be_immutable
class ScreenNotes extends StatefulWidget {
  ScreenNotes({super.key});
  bool darkmode = false;
  final List<String> list = List.generate(10, (index) => "Note $index");

  @override
  State<ScreenNotes> createState() => _ScreenNotesState();
}

class _ScreenNotesState extends State<ScreenNotes> {

  late final Box contactBox;

  // Delete info from people box
  _deleteInfo(int index) {
    contactBox.deleteAt(index);
  }

  bool _isGridMode = false;

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    contactBox = Hive.box('NoteBox');
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
            onPressed: () {
              if (Notes.themeNotifier.value == ThemeMode.light) {
                Notes.themeNotifier.value = ThemeMode.dark;
                widget.darkmode = true;
              } else {
                Notes.themeNotifier.value = ThemeMode.light;
                widget.darkmode = false;
              }
              print(widget.darkmode);
            },
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
                            Get.to(() => ScreenAddNotes());
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
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ScreenUpdateNotes(
                              index: index,
                              person: personData,
                            ),
                          ),
                        ),
                        child: ListTile(
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
                            onPressed: () => _deleteInfo(index),
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ScreenAddNotes());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

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
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
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
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
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
