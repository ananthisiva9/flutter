import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:http/http.dart' as http;
import '../../DisplayScreen.dart';
import '../Learnit.dart';

class DeliveryProcess extends StatefulWidget {
  @override
  _DeliveryProcessState createState() => _DeliveryProcessState();
}

class _DeliveryProcessState extends State<DeliveryProcess> {
  var url, notes;
  TextEditingController _notesController = TextEditingController();
  late String data;
  bool isLoading = true;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  note(String notes) async {
    String url = clientApi.add_notes;
    Map body = {"module": "delivery process", "notes": notes};
    String? token = await getToken();
    if (token != null) {
      var res = await http.post(
        Uri.parse(url),
        headers: {"Authorization": "Token ${token}"},
        body: body,
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Your Notes Submitted Successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Notes not Submitted ,Please Write your Notes again'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LearnIt()),
          );
        });
      }
    }
  }

  fetchData() async {
    String? token = await getToken();
    String url = clientApi.video + "?module=delivery process";
    if (token != null) {
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': "Token $token",
      });
      if (response.statusCode == 200) {
        data = response.body;
        print(data);
        setState(() {
          late String subString, videoId;
          isLoading = false;
          data = response.body;
          url = jsonDecode(data)['video']['url'];
          notes = jsonDecode(data)['note']['notes'];
          _notesController.text = jsonDecode(response.body)['note']["notes"];
          if (url.toString().contains("embed")) {
            subString = url.substring(url.toString().lastIndexOf("/"));
            print("SUBSTRING : " + subString);
            videoId = subString.substring(1);
            print("videoId : " + videoId);
            print(notes);
          }
          _controller = YoutubePlayerController(
            initialVideoId: videoId,
            params: YoutubePlayerParams(
              showControls: true,
              showFullscreenButton: true,
              privacyEnhanced: true,
              loop: true,
            ),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Login Details not found. You will be rerouted to the login page'),
        backgroundColor: Colors.red,
      ));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      });
    }
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hi, Super Mom',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/appbar.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            elevation: 0,
            actions: [
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClientDisplay()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.asset('assets/Background.png').image,
                      fit: BoxFit.cover)),
            ),
            isLoading
                ? Center(child: LoadingIcon())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      _buildName(),
                      Padding(
                        padding: EdgeInsets.only(right: 25),
                        child: Image(
                          alignment: Alignment.bottomRight,
                          image: AssetImage('assets/Motherhood-bro.png'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width * 1.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: Image.asset('assets/Background.png')
                                        .image,
                                    fit: BoxFit.cover),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Divider(
                                          height: 50,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Delivery Process",
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 22.5,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: 'Gilroy',
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      height: 5,
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 15),
                                      child: YoutubePlayerControllerProvider(
                                        controller: _controller,
                                        child: YoutubePlayerIFrame(
                                          controller: _controller,
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: _buildNotes(),
                                    ),
                                    _buildNextBtn(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  late String Note;
  Widget _buildNotes() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        minLines: 2,
        maxLines: 100,
        maxLength: 1500,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          setState(() {
            Note = value;
          });
        },
        controller: _notesController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 25),
          width: 5 * (MediaQuery.of(context).size.width / 09),
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589), // foreground (text) color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: _notesController.text == ""
                ? null
                : () {
                    note(
                      _notesController.text,
                    );
                  },
            child: Text(
              "Submit Notes",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 20,
                fontFamily: 'Avenir',
              ),
            ),
          ),
        ),
      ],
    );
  }

  getToken() async {
    dynamic userDetails = await Global.getUserDetails();
    if (userDetails != null && userDetails is LoginModel) {
      return userDetails.token;
    }
  }
}
