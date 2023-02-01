import 'package:flutter/material.dart';
import 'CallRecords_model.dart';
import 'Notes.dart';

class Search extends SearchDelegate<Calls?> {
  Search(this.calls);

  List<Calls> calls;

  List<Calls> filteredcalls = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
            progress: transitionAnimation, icon: AnimatedIcons.menu_arrow));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (filteredcalls[index].id != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Notes(value: filteredcalls[index].note!)),
              );
            }
          },
          child: ListTile(
              title:  TextButton(
                onPressed: () { Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Notes(value: filteredcalls[index].note!)),
                ); }, child: Text(
                ( filteredcalls[index].date!) ,
              ),)
          ),
        );
      },
      itemCount: filteredcalls.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // List<Customers> suggestionList = [];
    print("query : " + query);
    if (query.isEmpty) {
      filteredcalls = calls;
    } else {
      if (filteredcalls.isEmpty) {
        filteredcalls = calls
            .where((element) =>
        (element.date != null &&
            element.date!.contains(query)))
            .toList();
      } else {
        filteredcalls = filteredcalls.where((element) {
          if (element.date != null && element.date!.contains(query)) {
            return true;
          } else {
            return false;
          }
        }).toList();
      }
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (filteredcalls[index].id != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Notes(value: filteredcalls[index].note!)),
              );
            }
          },
          child: ListTile(
            leading: null,
            title: Text((filteredcalls[index].date ?? "")
            ),
          ),
        );
      },
      itemCount: filteredcalls.length,
    );
  }
}