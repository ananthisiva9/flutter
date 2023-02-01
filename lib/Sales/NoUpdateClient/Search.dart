import 'package:admin_dashboard/Sales/ClientProfile/ClientProfile.dart';
import 'package:flutter/material.dart';
import 'NoUpdateClient_model.dart';

class DataSearch extends SearchDelegate<Client?> {
  DataSearch(this.totalPatientsDetails);
  List<Client> totalPatientsDetails;
  List<Client> filteredclients = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
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
                    builder: (context) => ClientProfile(
                        value: filteredclients[index].id!)),
              );
            }
          },
          child: ListTile(
            leading: const Icon(Icons.person),
            title: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClientProfile(
                          value: filteredclients[index].id!)),
                );
              },
              child: Text(
                (filteredclients[index].firstName ?? "") +
                    " " +
                    (filteredclients[index].lastName ?? ""),
              ),
            ),
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
      filteredclients = totalPatientsDetails;
      // query.isEmpty ? filteredclients : clients
    } else {
      if (filteredclients.isEmpty) {
        filteredclients = totalPatientsDetails
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
                    builder: (context) => ClientProfile(
                        value: filteredclients[index].id!)),
              );
            }
          },
          child: ListTile(
            leading: const Icon(Icons.person),
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
