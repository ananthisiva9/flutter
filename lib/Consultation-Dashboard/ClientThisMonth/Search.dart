import 'package:flutter/material.dart';
import 'package:shebirth/Consultation-Dashboard/ClientProfile.dart';
import 'package:shebirth/Consultation-Dashboard/Tracker/DailyTracker.dart';
import 'ClientThisMonth_model.dart';

class Search extends SearchDelegate<ClientThisMonthItem?> {
  Search(this.clients);

  List<ClientThisMonthItem> clients;

  List<ClientThisMonthItem> filteredclients = [];

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
            if (filteredclients[index].id != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DailyTracker(filteredclients[index].id!)),
              );
            }
          },
          child: ListTile(
              leading: Icon(Icons.person),
              title: TextButton(
                onPressed: () {
                },
                child: Text(
                  (filteredclients[index].firstName ?? "") +
                      " " +
                      (filteredclients[index].lastName ?? ""),
                ),
              )),
        );
      },
      itemCount: filteredclients.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // List<Customers> suggestionList = [];
    print("query : " + query);
    if (query.isEmpty) {
      filteredclients = clients;
      // query.isEmpty ? filteredclients : clients
    } else {
      if (filteredclients.isEmpty) {
        filteredclients = clients
            .where((element) => (element.firstName != null &&
                element.firstName!.contains(query)))
            .toList();
      } else {
        filteredclients = filteredclients.where((element) {
          if (element.firstName != null && element.firstName!.contains(query)) {
            return true;
          } else if (element.lastName != null &&
              element.lastName!.contains(query)) {
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
            if (filteredclients[index].id != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DailyTracker(filteredclients[index].id!)),
              );
            }
          },
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text((filteredclients[index].firstName ?? "") +
                " " +
                (filteredclients[index].lastName ?? "")),
          ),
        );
      },
      itemCount: filteredclients.length,
    );
  }
}
