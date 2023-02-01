import 'package:flutter/material.dart';
import 'package:shebirth/Doctor-Dashboard/ClientProfile/ClientProfile.dart';
import 'package:shebirth/Doctor-Dashboard/Tracker/DailyTracker.dart';

import 'AppointmentsModel.dart';

class Search extends SearchDelegate<AppointmentTypeModel?> {
  Search(this.clients);

  List<AppointmentTypeModel> clients;

  List<AppointmentTypeModel> filteredclients = [];

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
            title:  TextButton(
              onPressed: () { Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ClientProfile(value: filteredclients[index].id.toString(),)),
              ); }, child: Text((filteredclients[index].clientName ?? "")),)
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
            .where((element) =>
        (element.clientName != null &&
            element.clientName!.contains(query)))
            .toList();
      } else {
        filteredclients = filteredclients.where((element) {
          if (element.clientName != null && element.clientName!.contains(query)) {
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
            title: Text((filteredclients[index].clientName ?? "")),
          ),
        );
      },
      itemCount: filteredclients.length,
    );
  }
}