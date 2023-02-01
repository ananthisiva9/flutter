import 'package:flutter/material.dart';
import 'DoctorList/DoctorList_model.dart';

class DoctorSearch extends SearchDelegate<DoctorListItem?> {
  DoctorSearch(this.clients);
  List<DoctorListItem> clients;

  List<DoctorListItem> filteredclients = [];

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
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text((filteredclients[index].firstname ?? "") +
                " " +
                (filteredclients[index].lastname ?? "")),
          ),
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
            .where((element) => (element.firstname != null &&
                element.firstname!.contains(query)))
            .toList();
      } else {
        filteredclients = filteredclients.where((element) {
          if (element.firstname != null && element.firstname!.contains(query)) {
            return true;
          } else if (element.lastname != null &&
              element.lastname!.contains(query)) {
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
          child: ListTile(
            leading: Icon(Icons.person),
            title: TextButton(
              onPressed: () { }, child: Text((filteredclients[index].firstname ?? "")),)
          ),
        );
      },
      itemCount: filteredclients.length,
    );
  }
}
