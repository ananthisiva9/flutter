import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shebirth/Client-Dashboard/DisplayScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shebirth/Client-Dashboard/MessageScreen/Massage/Message.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';

class DoctorChat extends StatefulWidget {
  @override
  _DoctorChatState createState() => _DoctorChatState();
}

class _DoctorChatState extends State<DoctorChat> {
  var id, firstname, lastname, speciality, image_url;
  late String data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String? token = await getToken();
    String url = clientApi.doctor_messages;
    if (token != null) {
      var response = await http
          .get(Uri.parse(url), headers: {'Authorization': "Token $token"});
      if (response.statusCode == 200) {
        data = response.body;
        print(data);
        setState(() {
          isLoading = false;
          data = response.body;
          id = jsonDecode(data)['id'];
          firstname = jsonDecode(data)['firstname'];
          lastname = jsonDecode(data)['lastname'];
          speciality = jsonDecode(data)['speciality'];
          image_url = jsonDecode(data)['image_url'];
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Doctor Not Found'),
        backgroundColor: Colors.red,
      ));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClientDisplay()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.asset('assets/Background.png').image,
                      fit: BoxFit.cover)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SingleChildScrollView(
                    child: isLoading
                        ? Center(child: LoadingIcon())
                        : _buildContainer()),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          child: InkWell(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 1.0,
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      height: 100,
                      width: 420,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: image_url == null
                                      ? CircleAvatar(
                                    backgroundColor: Colors.cyan[100],
                                    backgroundImage: AssetImage('assets/Client dummy.png'),
                                    radius: 35,
                                  )
                                      : CircleAvatar(
                                    backgroundColor: Colors.cyan[100],
                                    backgroundImage: NetworkImage(
                                     image_url.toString(),
                                    ),
                                    radius: 35,
                                  ),
                                ),
                                    Text(
                                        firstname.toString().capitalize(),
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                    ),
                                    SizedBox(height: 50),
                                  ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MessagesScreen(id.toString(),
                            firstname.toString(), image_url.toString())),
              );
            },
          ),
        ),
      ],
    );
  }
}
